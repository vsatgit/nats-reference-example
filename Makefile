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

.PHONY: cleanup-nats
cleanup-nats:
	docker-compose rm -s -v -f nats-box nats-server
	rm -rf $(NATS_CONFIG_DIR)/nsc $(NATS_CONFIG_DIR)/creds $(NATS_SERVER_CONF_DIR)/resolver.conf

.PHONY: setup-nats
setup-nats:
	bash $(NATS_SCRIPTS_DIR)/generate_nats_keys.sh

## resetup-nats: configures authZ and authN on NATS using newly generated JWT and NKSeed 
.PHONY: resetup-nats
resetup-nats: cleanup-nats setup-nats
