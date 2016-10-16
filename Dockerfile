FROM alpine

RUN \
    apk update && \
    apk add git mercurial postgresql-client mysql-client bash && \
    rm -rvf /var/cache/apk/* && \
    true

ADD importer.py mysqldump_splitsort.py pg_dump_splitsort.py dump_databases.sh scm.sh /backup/

RUN \
    chmod -Rv guo+rx-w /backup/ && \
    echo user=${USER} uid=${UID} && \
    adduser ${USER} -u ${UID} -D -s bash && \
    true

USER ${USER}

ENTRYPOINT ["/bin/bash", "/backup/dump_databases.sh"]