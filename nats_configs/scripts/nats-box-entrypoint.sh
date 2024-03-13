#!/busybox/sh
# (C) Copyright 2024 Hewlett Packard Enterprise Development LP

# distroless busybox's shell is ash, not at /bin/sh
set -eu

NKEYS_PATH=/nsc/nkeys

if [[ -d "${NKEYS_PATH}" ]]; then
    nsc push -A -u ${NATS_URL}
    nsc describe account -n ${ACCOUNT_NAME}
    nsc describe user -a ${ACCOUNT_NAME} -n ${USER_NAME}
    nsc describe user -a ${ACCOUNT_NAME} -n ${FUNCTIONAL_TEST_USER_NAME}
fi

# execute passed-in parameters
tail -f /dev/null
