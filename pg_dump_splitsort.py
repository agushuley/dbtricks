#!/usr/bin/env python2.7

import heapq
import json
import os

import re
import tempfile
import importer


def _try_as_float(s):
    if not s or s[0] not in '0123456789.-':
        # optimization
        return s
    try:
        return float(s)
    except ValueError:
        return s


def _lines_compare(l1, l2):
    p1 = l1.split('\t', 1)
    p2 = l2.split('\t', 1)
    result = cmp(_try_as_float(p1[0]), _try_as_float(p2[0]))
    if not result and len(p1) > 1 and len(p2) > 1:
        return _lines_compare(p1[1], p2[1])
    return result


def key(line):
    keys = line.split('\t')
    if len(keys) >= 2:
        return _try_as_float(keys[0]), _try_as_float(keys[1])
    else:
        return _try_as_float(keys[0]), None


class _Dumper:
    def __init__(self):
        self._output = None
        self._buf = []

    def flush(self):
        if not self._output:
            raise ValueError("Output is no opened during flush")
        self._output.writelines(self._buf)
        self._output.flush()
        self._buf = []

    def new_output(self, path):
        if self._output:
            self.flush()
            self._output.close()
        self._output = file(path, 'w')

    def pop_last_lines(self, lines=1):
        accum = []
        if lines > 0:
            while lines > 0 and len(self._buf) > 0:
                accum.append(self._buf.pop())
                lines -= 1
            accum.reverse()
        return accum

    def add_lines(self, lines):
        self._buf.extend(lines)

    def append(self, line):
        self._buf.append(line)

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self._output:
            self.flush()
            self._output.close()
            self._output = None

# class _Dumper


_END_COPY_LINE = '\\.\n'


class _DataHandler:
    def __init__(self, max_chunk_size, start_line, table_name, counter):
        self._max_chunk_size = max_chunk_size

        self._start_line = start_line
        self._table_name = table_name
        self._counter = counter

        self._buf = []
        self._buf_size = 0
        self._chunks = []
        self._flushed = False

    def add_line(self, line):
        if self._flushed:
            raise ValueError("Can't add table data, table interaction already flushed")
        self._buf.append(line)
        self._buf_size += len(line)
        if self._buf_size > self._max_chunk_size:
            importer.verbose("Splitting %s temporary data, %d-th part, %d lines, size %d" %
                             (self._table_name, len(self._chunks) + 1, len(self._buf), self._buf_size))

            self._buf.sort(cmp=_lines_compare)
            chunk = tempfile.TemporaryFile("r+w")
            chunk.writelines(self._buf)
            chunk.seek(0)

            self._chunks.append(chunk)
            self._buf_size = 0
            self._buf = []

    # add_line

    def flush_data(self, dumper):
        if self._flushed:
            raise ValueError("Can't add table data, table interaction already flushed")
        importer.verbose("Storing %s data, %d lines in memory, size %d" %
                         (self._table_name, len(self._buf), self._buf_size))
        self._buf.sort(cmp=_lines_compare)

        if len(self._chunks):
            # multiple chunks
            sequence = 1
            dumper.append(self._start_line)
            output_size = 0
            sorted_memory = ((key(line), line) for line in self._buf)
            sorted_chunks = (((key(line), line) for line in chunk)
                             for chunk in self._chunks)
            for _key, _line in heapq.merge(sorted_memory, *sorted_chunks):
                dumper.append(_line)
                output_size += len(_line)
                if output_size > self._max_chunk_size:
                    dumper.append(_END_COPY_LINE)
                    dumper.flush()

                    dumper.new_output('{counter}_{table_name}_{sequence}.sql'.format(
                        counter=self._counter, table_name=self._table_name,
                        sequence=importer.str_in_base(sequence, min_with=4)))
                    output_size = 0
                    sequence += 1

                    dumper.append(self._start_line)
                    # for _key _ine in sorted data
        else:
            dumper.append(self._start_line)
            dumper.add_lines(self._buf)

        dumper.append(_END_COPY_LINE)
        dumper.flush()

        for chunk in self._chunks:
            chunk.close()
        self._chunks = []
        self._buf_size = 0
        self._buf = []

        self._flushed = True
        # flush_data

# class _DataHandler


COPY_RE = re.compile(r'COPY .*? \(.*?\) FROM stdin;\n$')
DATA_COMMENT_RE = r'-- Data for Name: (?P<table>.*?); Type: TABLE DATA; Schema: (?P<schema>.*?);'
CONSTRAINT_COMMENT_RE = r'-- Name: .*; Type: (.*CONSTRAINT|INDEX); Schema: '


def __do_split(args, sql_dump_file, order):
    with _Dumper() as dumper:
        counter = 0
        previous_table = None
        dumper.new_output('0000_prologue.sql')
        table_name = None
        epilogue = False
        data_handler = None

        for line in sql_dump_file:
            if data_handler:
                if line == _END_COPY_LINE:
                    data_handler.flush_data(dumper)
                    data_handler = None
                    previous_table = table_name
                    counter = 0
                else:
                    data_handler.add_line(line)
            else:  # not data_handler.is_data
                if epilogue or line in ('\n', '--\n'):
                    dumper.append(line)
                elif re.match(CONSTRAINT_COMMENT_RE, line):
                    backup = dumper.pop_last_lines(2)
                    dumper.flush()
                    dumper.new_output('zzzz_epilogue.sql')
                    dumper.add_lines(backup)
                    dumper.append(line)
                    epilogue = True
                else:
                    matcher = re.match(DATA_COMMENT_RE, line)
                    if matcher:
                        table_name = '{schema}.{table}'.format(
                            schema=matcher.groupdict()['schema'], table=matcher.groupdict()['table'])
                        counter = importer.get_order_number(order, table_name, previous_table)

                        backup = dumper.pop_last_lines(2)
                        dumper.flush()
                        dumper.new_output('{counter}_{table_name}.sql'.format(
                            counter=counter, table_name=table_name))
                        dumper.add_lines(backup)
                        dumper.append(line)
                    elif table_name and COPY_RE.match(line):
                        data_handler = _DataHandler(args.chunk_size, line, table_name, counter)
                    else:
                        dumper.append(line)

        # for every line


# def __do_import

if __name__ == '__main__':
    importer.split_sql_file(importer.create_argsparser(), __do_split=__do_split)
