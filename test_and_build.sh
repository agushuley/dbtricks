#!/usr/bin/env bash

set | grep GO

go get -v -t github.com/andriyg76/dbtricks/ \
    && go test -v github.com/andriyg76/dbtricks/ \
    && go test -v github.com/andriyg76/dbtricks/orders \
    && go test -v github.com/andriyg76/dbtricks/writer \
    && go test -v github.com/andriyg76/dbtricks/mergesort \
    && go test -v github.com/andriyg76/dbtricks/pg/dumpsplit \
    && go test -v github.com/andriyg76/dbtricks/pg/datasplit \
    && go test -v github.com/andriyg76/dbtricks/mysql/dumpsplit \
    && go test -v github.com/andriyg76/dbtricks/mysql/datasplit \
    && go install -v github.com/andriyg76/dbtricks #\
