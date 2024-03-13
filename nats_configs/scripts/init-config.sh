#!/bin/sh
# (C) Copyright 2024 Hewlett Packard Enterprise Development LP
set -eu

CUR_DIR="$( dirname -- "$0"; )"

nsc add operator ${OPERATOR_NAME};
nsc edit operator --service-url ${NATS_URL};
nsc add account -n SYS;
nsc edit operator --system-account SYS;
nsc add account ${ACCOUNT_NAME};
nsc edit account -n ${ACCOUNT_NAME} --js-disk-storage -1;
nsc generate config --nats-resolver > ./resolver.conf

source $CUR_DIR/user-config.sh
