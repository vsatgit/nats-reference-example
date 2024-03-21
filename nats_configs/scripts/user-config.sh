#!/bin/sh
# (C) Copyright 2024 Hewlett Packard Enterprise Development LP
set -eu

# update this file as per feature need

nsc add user \
    ${USER_NAME} \
    --allow-sub "${EVENT_SUBJECTS}" \
    --allow-sub "_INBOX.>" \
    --allow-pub "\$JS.API.STREAM.CREATE.${STREAM_NAME}" \
    --allow-pub "\$JS.API.STREAM.INFO.${STREAM_NAME}" \
    --allow-pub "\$JS.API.STREAM.NAMES" \
    --allow-pub "\$JS.ACK.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.INFO.${STREAM_NAME}" \
    --allow-pub "\$JS.API.CONSUMER.INFO.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.CREATE.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.MSG.NEXT.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.STREAM.PURGE.${STREAM_NAME}";

nsc add user \
    ${FUNCTIONAL_TEST_USER_NAME} \
    --allow-pubsub "${EVENT_SUBJECTS}" \
    --allow-sub "_INBOX.>" \
    --allow-pub "\$JS.ACK.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.CREATE.${STREAM_NAME}" \
    --allow-pub "\$JS.API.CONSUMER.CREATE.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.DELETE.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.UPDATE.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.DURABLE.CREATE.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.DURABLE.UPDATE.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.INFO.${STREAM_NAME}" \
    --allow-pub "\$JS.API.CONSUMER.INFO.${STREAM_NAME}.>" \
    --allow-pub "\$JS.API.CONSUMER.MSG.NEXT.${STREAM_NAME}.*" \
    --allow-pub "\$JS.API.INFO" \
    --allow-pub "\$JS.API.STREAM.CREATE.${STREAM_NAME}" \
    --allow-pub "\$JS.API.STREAM.DELETE.${STREAM_NAME}" \
    --allow-pub "\$JS.API.STREAM.INFO.${STREAM_NAME}" \
    --allow-pub "\$JS.API.STREAM.NAMES";