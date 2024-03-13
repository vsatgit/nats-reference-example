#!/bin/sh
# (C) Copyright 2024 Hewlett Packard Enterprise Development LP
set -eu

nsc add user \
    ${USER_NAME} \
    --allow-pubsub "${EVENT_SUBJECTS}" \
    --allow-sub "_INBOX.>" \
    --allow-pub "\$JS.API.STREAM.CREATE.${STREAM_NAME}" \
    --allow-pub "\$JS.API.STREAM.INFO.${STREAM_NAME}" \
    --allow-pub "\$JS.ACK.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.INFO.${STREAM_NAME}" \
    --allow-pub "\$JS.API.CONSUMER.INFO.${STREAM_NAME}.*" \
    --allow-pub "\$JS.API.CONSUMER.CREATE.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.MSG.NEXT.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.STREAM.PURGE.${STREAM_NAME}";