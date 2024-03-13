#!/bin/bash -d

docker-compose up -d nats-box 
docker-compose exec -ti nats-box /bin/sh -c "/user_scripts/configure_nsc.sh"
mkdir -p  ./nats_configs/creds

docker-compose cp nats-box:/nsc/nkeys/creds/TestOperator/TestAccount/TestUser.creds ./nats_configs/creds/user.creds
docker-compose cp nats-box:/root/resolver.conf ./nats_configs/server_configs/resolver.conf

docker-compose rm -s -v -f nats-server 
docker-compose up -d nats-server
sleep 1
docker-compose restart nats-box
