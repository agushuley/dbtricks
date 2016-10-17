FROM andriyg/dbtricks

ARG USER_ID=
ARG USER= 

RUN \
    set && \
    echo adduser $USER -u $USER_ID -D -s bash && \
    adduser $USER -u $USER_ID -D -s bash && \
    true

USER $USER

