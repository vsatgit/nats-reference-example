# (C) Copyright 2023-2024 Hewlett Packard Enterprise Development LP

# Project directories
NATS_SCRIPTS_DIR    := ${PROJ_DIR}/build/ci/nats

HTTP_PROXY := ${http_proxy}
HTTPS_PROXY := ${https_proxy}

## help: output help for all targets
.PHONY: help
help:
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo
	@fgrep -h '##' $(MAKEFILE_LIST) | fgrep -v fgrep | column -t -s ':' | sed -e 's/## //'

.PHONY: cleanup-nats
cleanup-nats:
	docker-compose --profile events rm -s -v -f nats-box nats-server
	rm -rf $(NATS_SCRIPTS_DIR)/nsc
	rm -rf $(NATS_SCRIPTS_DIR)/keys

.PHONY: setup-nats
setup-nats:
	bash $(NATS_SCRIPTS_DIR)/generate_nats_keys.sh

## resetup-nats: configures authZ and authN on NATS using newly generated JWT and NKSeed 
.PHONY: resetup-nats
resetup-nats: cleanup-nats setup-nats
