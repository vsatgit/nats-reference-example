# (C) Copyright 2024 Hewlett Packard Enterprise Development LP

# Project directories
NATS_CONFIG_DIR    		:= ${PWD}/nats_configs
NATS_SCRIPTS_DIR    	:= ${NATS_CONFIG_DIR}/scripts
NATS_SERVER_CONF_DIR	:= ${NATS_CONFIG_DIR}/server_configs

## help: output help for all targets
.PHONY: help
help:
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo
	@fgrep -h '##' $(MAKEFILE_LIST) | fgrep -v fgrep | column -t -s ':' | sed -e 's/## //'

## configure-nats: initializes NATS with Authorization and Authentication configured based on provided environment variables
.PHONY: configure-nats
configure-nats:
	bash $(NATS_SCRIPTS_DIR)/configure-nats-with-jwts.sh

## nats-down: brings down nats-server and nats-box and removes them
.PHONY: nats-down
nats-down:
	docker-compose rm --stop --volumes --force nats-box nats-server

## cleanup-dirs: cleanup directories that stores NATS JWTs and NKeys
.PHONY: cleanup-dirs
cleanup-dirs:
	rm -rf $(NATS_CONFIG_DIR)/nsc $(NATS_CONFIG_DIR)/creds $(NATS_SERVER_CONF_DIR)/resolver.conf

## cleanup-nats: cleans up all NATS configuration related to Authorization and Authentication 
.PHONY: cleanup-nats
cleanup-nats: nats-down cleanup-dirs

## reconfigure-nats: reconfigures NATS with Authorization and Authentication after clearing the existing configuration
.PHONY: reconfigure-nats
reconfigure-nats: cleanup-nats configure-nats

## nats-start: start nats-server and nats-box containers
.PHONY: nats-start
nats-start:
	docker-compose -f docker-compose.yml start

## nats-stop: stop nats-server and nats-box containers
.PHONY: nats-stop
nats-stop:
	docker-compose -f docker-compose.yml stop	
