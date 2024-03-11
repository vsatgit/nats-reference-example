#!/busybox/sh

# distroless busybox's shell is ash, not at /bin/sh

set -eu

NATS_URL=nats://nats-server
export NSC_HOME=/nsc/.config/nats/nsc
export NKEYS_PATH=/nsc/nkeys

if [[ -d "${NKEYS_PATH}" ]]; then
    nsc push -A -u ${NATS_URL}
    nsc describe account
    nsc describe user -n TestUser
fi

# execute passed-in parameters
tail -f /dev/null
