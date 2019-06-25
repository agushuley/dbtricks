#!/usr/bin/env bash

SCRIPT_NAME="$( basename $0 )"
if [[ "$( uname )" == "Darwin" ]] ; then
    BASE_NAME="$( dirname $( greadlink -f $0 ) )"
else
    BASE_NAME="$( dirname $( readlink -f $0 ) )"
fi

function print_error() {
	echo $( date "+%y-%m-%d %H:%M:%S" ) ${SCRIPT_NAME} $@ 1>&2
}

function panic() {
    print_error $@
    exit 1
}

function dir_check_scm() { echo "Have to be defined $FUNCNAME $1 $2 $3"; exit 1; }
function dir_push_scm() { echo "Have to be defined $FUNCNAME $1 $2"; exit 1; }
case "${DO_NOT_CHECK_SCM}" in
    [Yy][Ee][Ss]|[Tt][Rr][Uu][Ee]|[1TtYy])
        function dir_check_scm() { true; }
        function dir_push_scm() { true; }
        ;;
    *)
        source ${BASE_NAME}/scm.sh \
            || panic "$0 Can't load scm library "
esac

cd /tmp

PG_BACKUPS=${PG_BACKUPS:-N}
PG_BACKUPS_DIR="${PG_BACKUPS_DIR:-$HOME/var/backups/pg}"
# if databases are empty, all databases will be backed up, except ( "template*" )
PG_DATABASES="${PG_DATABASES:-}"
# if no, global objects will not be dumped (pg_dumpall -g)
PG_NO_GLOBALS="${PG_NO_GLOBALS:-}"
# if coppenction is empty, plain plsql call will be used without host, user, pass
# mode=sudo, sudo -u ${pg_backups_user} psql commad will be used for connect to psql
# mode=host, psql -H ${pg_backups_host}  will be used, user param -P will be added
# if they are not empty, if password is not empty, PGPASSWORD variable will be set, or
# password can be written into ~/.pgpass file
PG_CONNECTION=${PG_CONNECTION:-}
PG_HOST=${PG_HOST:-}
PG_USER=${PG_USER:-}
PG_PASSWORD=${PG_PASSWORD:-}

MYSQL_BACKUPS=${MYSQL_BACKUPS:-}
MYSQL_BACKUPS_DIR="${MYSQL_BACKUPS_DIR:-$HOME/var/backups/mysql}"
# if databases are empty, all databases will be backed up
MYSQL_DATABASES=${MYSQL_DATABASES:-}
MYSQL_DATABASE=${MYSQL_DATABASE:-}
# if MYSQL_DATABASE is set and not MYSQL_BACKUPS defined, we dumping docker based mysql database
if [[ -z "${MYSQL_DATABASES}" && -z "${MYSQL_BACKUPS}" && ! -z "${MYSQL_DATABASE}" ]] ; then
    MYSQL_HOST="${MYSQL_HOST:-mysql}"
    MYSQL_DATABASES="${MYSQL_DATABASE}"
    MYSQL_BACKUPS=Y
fi
# plain mysqldump call will be used with host, user, pass added, if variables will be difined
MYSQL_HOST=${MYSQL_HOST:-}
MYSQL_USER=${MYSQL_USER:-}
MYSQL_PASSWORD=${MYSQL_PASSWORD:-}

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
                    pg_prefix=""
                    export PGPASSWORD="${PG_PASSWORD}"
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
                panic "Invalid PG_CONNECTION value ${PG_CONNECTION}, has to be sudo|host or empty"
            ;;
        esac

        if [[ -z "${PG_DATABASES}" ]] ; then
            PG_DATABASES=$( ${pg_prefix} psql ${pg_suffix} -t -c "select datname from pg_database where datname not like 'template%';" postgres )
        fi

        mkdir -p "${PG_BACKUPS_DIR}" || panic "Can't create target databases dump dir ${PG_BACKUPS_DIR}"

        case "${PG_NO_GLOBALS}" in
            [Yy][Ee][Ss]|[Yy1]|[Tt][Rr][Uu][Ee])
            ;;
            *)

                LOCKFILE=${PG_BACKUPS_DIR}/globals.LOCK
                if ( set -o noclobber; echo "locked" > "${LOCKFILE}") 2> /dev/null ; then
                    trap "rm -f \"${LOCKFILE}\"" INT TERM EXIT
                    {
                        _scm=
                        mkdir -p "${PG_BACKUPS_DIR}/globals" \
                            && dir_check_scm "${PG_BACKUPS_DIR}/globals" _scm "Y" \
                            && ${pg_prefix} pg_dumpall ${pg_suffix} -g > ${PG_BACKUPS_DIR}/globals/globals.sql \
                            && dir_push_scm "${PG_BACKUPS_DIR}/globals" "${_scm}"
                    } || print_error "Error backup database server globals"
                    rm -f ${LOCKFILE}
                else
                    print_error "pgglobals lock file ${LOCKFILE} exist, globals backup skipped"
                fi
        esac

        pg_split="${BASE_NAME}/pg_dump_splitsort.py"

        for database in ${PG_DATABASES} ; do
            LOCKFILE=${PG_BACKUPS_DIR}/${database}.LOCK
            if ( set -o noclobber; echo "locked" > "${LOCKFILE}") 2> /dev/null ; then
                trap "rm -f \"${LOCKFILE}\"" INT TERM EXIT
            else
                print_error "Database lock file ${LOCKFILE} exist, database ${database} backup skipped"
                continue
            fi
            {
                _scm=
                sql_dump_file=${PG_BACKUPS_DIR}/${database}.sql
                mkdir -p "${PG_BACKUPS_DIR}/${database}" \
                    && ${pg_prefix} pg_dump ${pg_suffix} ${database} > ${sql_dump_file} \
                    && dir_check_scm "${PG_BACKUPS_DIR}/${database}" _scm "Y" \
                    && "${pg_split}" ${sql_dump_file} -d ${PG_BACKUPS_DIR}/${database}/ -c \
                    && dir_push_scm "${PG_BACKUPS_DIR}/${database}" "${_scm}"
            } || print_error "$0 Error backuping database ${database}"
            rm -f ${sql_dump_file} ${LOCKFILE}
        done
    ;;
    *)
    ;;
esac

case "${MYSQL_BACKUPS}" in
    [Yy][Ee][Ss]|[Yy]|[1]|[Tt][Rr][Uu][Ee])
        mysql_suffix=""
        mysql_env=""
        if [[ ! -z "${MYSQL_PASSWORD}" ]] ; then
            mysql_env="MYSQL_PWD=\"${MYSQL_PASSWORD}\" ${mysql_env}"
        fi

        if [[ ! -z "${MYSQL_USER}" ]] ; then
            mysql_suffix="${mysql_suffix} --user=${MYSQL_USER}"
        fi

        if [[ ! -z "${MYSQL_HOST}" ]] ; then
            mysql_suffix="${mysql_suffix} --host=${MYSQL_HOST}"
        fi

        if [[ ! -z "${MYSQL_PORT}" ]] ; then
            mysql_suffix="${mysql_suffix} --port=${MYSQL_PORT}"
        fi

        if [[ -z "${MYSQL_DATABASES}" ]] ; then
            MYSQL_DATABASES=$( echo 'show databases' | eval ${mysql_env} mysql ${mysql_suffix} -N )
        fi

        mkdir -p "${MYSQL_BACKUPS_DIR}" \
            || panic "Can't create target databases dump dir ${MYSQL_BACKUPS_DIR}"

        mysql_split="${BASE_NAME}/mysqldump_splitsort.py"

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
                print_error"Database lock file ${LOCKFILE} exist, database ${database} backup skipped"
                continue
            fi
            {
                _scm=
                sql_dump_file=${MYSQL_BACKUPS_DIR}/${database}.sql
                mkdir -p "${MYSQL_BACKUPS_DIR}/${database}" \
                    && eval ${mysql_env} mysqldump ${mysql_suffix} --result-file="${sql_dump_file}" "${database}" -c --skip-opt --skip-dump-date --create-options \
                    && dir_check_scm "${MYSQL_BACKUPS_DIR}/${database}" _scm "Y" \
                    && "${mysql_split}" ${sql_dump_file} -d ${MYSQL_BACKUPS_DIR}/${database}/ -c \
                    && dir_push_scm "${MYSQL_BACKUPS_DIR}/${database}" "${_scm}"
            } || print_error "Error backuping database ${database}" 1>&2
            rm -f ${sql_dump_file} ${LOCKFILE}
        done
    ;;
    *)
    ;;
esac
