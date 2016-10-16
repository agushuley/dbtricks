FROM alpine

ADD importer.py mysqldump_splitsort.py pg_dump_splitsort.py /backup/

RUN \
    apk update && \
    apk add git mercurial postgresql-client mysql-client bash && \
    rm -rvf /var/cache/apk/* && \
    chmod -Rv guo+rx-w /backup/ && \
    true

