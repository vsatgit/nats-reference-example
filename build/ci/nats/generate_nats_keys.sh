#!/bin/bash -d

DOCKER_PROFILE=nats

docker-compose --profile ${DOCKER_PROFILE} up -d nats-box 
docker-compose --profile ${DOCKER_PROFILE} exec -ti nats-box /bin/sh -c "/build/configure_nsc.sh"
mkdir -p ./build/ci/nats/config ./build/ci/nats/keys

docker-compose --profile ${DOCKER_PROFILE} cp nats-box:/nsc/nats/nsc/stores/TestOperator/TestOperator.jwt ./build/ci/nats/keys/operator.jwt
docker-compose --profile ${DOCKER_PROFILE} cp nats-box:/nsc/nkeys/creds/TestOperator/TestAccount/TestUser.creds ./build/ci/nats/keys/user.creds


rm -rf ./build/ci/nats/nsc/nkeys/.gitignore

docker-compose --profile ${DOCKER_PROFILE} rm -s -v -f nats-server 
docker-compose --profile ${DOCKER_PROFILE} up -d nats-server
sleep 1
docker-compose --profile ${DOCKER_PROFILE} restart nats-box
