#!/usr/bin/env bash

cd /tmp

PG_BACKUPS=${PG_BACKUPS:-N}
PG_BACKUPS_DIR="${PG_BACKUPS_DIR:-~/var/backups/pg}"
# if databases are empty, all databases will be backed up, except ( "template*" )
PG_DATABASES="${PG_DATABASES:-}"
# if no, global objects will not be dumped (pg_dumpall -g)
PG_NO_GLOBALS="${PG_NO_GLOBALS:-}"
# if coppenction is empty, plain plsql call will be used without host, user, pass
# mode=sudo, sudo -u ${pg_backups_user} psql commad will be used for connect to psql
# mode=host, psql -H ${pg_backups_host}  will be used, user param -P will be added
# if they are not empty, if password is not empty, PGPASSWORD variable will be set, or
# password can be written into ~/.pgpass file
PG_CONNECTION=
PG_HOST=
PG_USER=
PG_PASSWORD=

MYSQL_ENABLED=
MYSQL_BACKUPS_DIR="${MYSQL_BACKUPS_DIR:-~/var/backups/mysql}"
# if databases are empty, all databases will be backed up
MYSQL_DATABASES=
# plain mysqldump call will be used with host, user, pass added, if wariables will be difined
MYSQL_HOST=
MYSQL_USER=
MYSQL_PASSWORD=

function dir_check_scm() { echo "Have to be defined $FUNCNAME $1 $2 $3"; exit 1; }
function dir_push_scm() { echo "Have to be defined $FUNCNAME $1 $2"; exit 1; }
{ scm_sh=$( dirname $0 )/scm.sh &&
source ${scm_sh}
} || {
    echo "$0 Can't load scm library " 1>&2
    exit 1
}

case "${PG_BACKUPS}" in
    [Yy][Ee][Ss]|[Yy]|[1]|[Tt][Rr][Uu][Ee])
        case "${PG_CONNECTION}" in
            [Ss][Uu][Dd][Oo])
                if [[ -z "${PG_USER}" ]] ; then
                    echo "$0 PG_USER should be set while connectint to database as sudo" 1>&2
                    exit 1
                fi
                pg_prefix="sudo -u ${PG_USER}"
                pg_suffix=""
            ;;
            [Hh][Oo][Ss][Tt])
                if [[ -z "${PG_HOST}" ]] ; then
                    echo "$0 PG_HOST should be set while connecting to database as host" 1>&2
                    exit 1
                fi
                if [[ ! -z "${PG_PASSWORD}" ]] ; then
                    pg_prefix="PGPASSWORD=\"${PG_PASSWORD}\""
                else
                    pg_prefix=""
                fi
                pg_suffix="-h ${PG_HOST}"
                if [[ ! -z "${PG_USER}" ]] ; then
                    pg_suffix="${pg_suffix} -U ${PG_USER}"
                fi
            ;;
            "")
                pg_prefix=""
                pg_suffix=""
            ;;
            *)
                echo "$0 invalid PG_CONNECTION value ${PG_CONNECTION}, has to be sudo|host or empty" 1>&2
                exit 1
            ;;
        esac

        if [[ -z "${PG_DATABASES}" ]] ; then
            PG_DATABASES=$( ${pg_prefix} psql ${pg_suffix} -t -c "select datname from pg_database where datname not like 'template%';" postgres )
        fi

        mkdir -p "${PG_BACKUPS_DIR}" || {
        echo "$0 Can't create target databases dump dir ${PG_BACKUPS_DIR}" 1>&2
        exit 1
    }

        case "${PG_NO_GLOBALS}" in
            [Yy][Ee][Ss]|[Yy1]|[Tt][Rr][Uu][Ee])
            ;;
            *)
                LOCKFILE=${PG_BACKUPS_DIR}/globals.LOCK
                if ( set -o noclobber; echo "locked" > "${LOCKFILE}") 2> /dev/null ; then
                    trap "rm -f \"${LOCKFILE}\"" INT TERM EXIT
                    _scm=
                    mkdir -p "${PG_BACKUPS_DIR}/globals" \
                && dir_check_scm "${PG_BACKUPS_DIR}/globals" _scm "Y" \
                && ${pg_prefix} pg_dumpall ${pg_suffix} -g > ${PG_BACKUPS_DIR}/globals/globals.sql \
                && dir_push_scm "${PG_BACKUPS_DIR}/globals" "${_scm}" \
            || echo "$0 Error backup database server globals" 1>&2
                    rm -f ${LOCKFILE}
                else
                    echo "$0 pgglobals lock file ${LOCKFILE} exist, globals backup skipped" 1>&2
                fi
        esac

        pg_split=$( dirname $0 )/pg_dump_splitsort.py

        for database in ${PG_DATABASES} ; do
            LOCKFILE=${PG_BACKUPS_DIR}/${database}.LOCK
            if ( set -o noclobber; echo "locked" > "${LOCKFILE}") 2> /dev/null ; then
                trap "rm -f \"${LOCKFILE}\"" INT TERM EXIT
            else
                echo "$0 Database lock file ${LOCKFILE} exist, database ${database} backup skipped" 1>&2
                continue
            fi
            _scm=
            sql_dump_file=${PG_BACKUPS_DIR}/${database}.sql
            mkdir -p "${PG_BACKUPS_DIR}/${database}" \
            && ${pg_prefix} pg_dump ${pg_suffix} ${database} > ${sql_dump_file} \
            && dir_check_scm "${PG_BACKUPS_DIR}/${database}" _scm "Y" \
            && ${pg_split} ${sql_dump_file} -d ${PG_BACKUPS_DIR}/${database}/ -c \
            && dir_push_scm "${PG_BACKUPS_DIR}/${database}" "${_scm}" \
        || echo "$0 Error backuping database ${database}" 1>&2
            rm -f ${sql_dump_file} ${LOCKFILE}
        done
    ;;
    *)
    ;;
esac

case "${MYSQL_ENABLED}" in
    [Yy][Ee][Ss]|[Yy]|[1]|[Tt][Rr][Uu][Ee])
        mysql_prefix=""
        mysql_suffix=""

        if [[ ! -z "${MYSQL_PASSWORD}" ]] ; then
            mysql_suffix="${mysql_suffix} --password=${MYSQL_PASSWORD}"
        fi

        if [[ ! -z "${MYSQL_USER}" ]] ; then
            mysql_suffix="${mysql_suffix} --user=${MYSQL_USER}"
        fi

        if [[ ! -z "${MYSQL_HOST}" ]] ; then
            mysql_suffix="${mysql_suffix} --host=${PG_HOST}"
        fi

        if [[ -z "${MYSQL_DATABASES}" ]] ; then
            MYSQL_DATABASES=$( echo 'show databases' | mysql ${mysql_suffix} -N )
        fi

        mkdir -p "${MYSQL_BACKUPS_DIR}" || {
        echo "$0 Can't create target databases dump dir ${MYSQL_BACKUPS_DIR}" 1>&2
        exit 1
    }

        mysql_split="$( dirname $0 )/mysqldump_splitsort.py"

        for database in ${MYSQL_DATABASES} ; do
            if [[ ( "${database}" == "information_schema" ) || \
            ( "${database}" == "performance_schema" ) ]] ; \
        then
                continue
            fi
            LOCKFILE=${MYSQL_BACKUPS_DIR}/${database}.LOCK
            if ( set -o noclobber; echo "locked" > "${LOCKFILE}") 2> /dev/null ; then
                trap "rm -f \"${LOCKFILE}\"" INT TERM EXIT
            else
                echo "$0 Database lock file ${LOCKFILE} exist, database ${database} backup skipped" 1>&2
                continue
            fi
            _scm=
            sql_dump_file=${MYSQL_BACKUPS_DIR}/${database}.sql
            mkdir -p "${MYSQL_BACKUPS_DIR}/${database}" \
            && ${mysql_prefix} mysqldump ${mysql_suffix} --result-file=${sql_dump_file} ${database} -c --skip-opt --skip-dump-date \
            && dir_check_scm "${MYSQL_BACKUPS_DIR}/${database}" _scm "Y" \
            && ${mysql_split} ${sql_dump_file} -d ${MYSQL_BACKUPS_DIR}/${database}/ -c \
            && dir_push_scm "${MYSQL_BACKUPS_DIR}/${database}" "${_scm}" \
        || echo "$0 Error backuping database ${database}" 1>&2
            rm -f ${sql_dump_file} ${LOCKFILE}
        done
    ;;
    *)
    ;;
esac
