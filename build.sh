#!/usr/bin/env bash

set | grep GO

go install -v github.com/andriyg76/dbtricks #\
exit $?