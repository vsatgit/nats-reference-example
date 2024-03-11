#!/bin/sh

EVENT_SUBJECT=${2:-test.events.>}
USER=${4:-TestUser}
ACCOUNT=${5:-TestAccount}
OPERATOR=${6:-TestOperator}
NATS_URL=nats://nats-server

nsc add operator ${OPERATOR};
nsc edit operator --service-url ${NATS_URL};
nsc add account -n SYS;
nsc edit operator --system-account SYS;
nsc add account ${ACCOUNT};
nsc edit account --name ${ACCOUNT} --js-mem-storage -1 --js-disk-storage -1 --js-streams -1 --js-consumer -1;
nsc edit account --name ${ACCOUNT} --allow-sub "${EVENT_SUBJECT}";
nsc add user \
			${USER} \
			--allow-pubsub "${EVENT_SUBJECT}" \
			--allow-sub "_INBOX.>" \
			--allow-pub "\$JS.API.STREAM.CREATE.test" \
			--allow-pub "\$JS.API.STREAM.INFO.test" \
			--allow-pub "\$JS.ACK.test.>" \
			--allow-pub "\$JS.API.CONSUMER.INFO.test" \
			--allow-pub "\$JS.API.CONSUMER.INFO.test.>" \
			--allow-pub "\$JS.API.CONSUMER.CREATE.test.>" \
			--allow-pub "\$JS.API.CONSUMER.MSG.NEXT.test.>" \
			--allow-pub "\$JS.API.STREAM.PURGE.test";