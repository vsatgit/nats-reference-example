# (C) Copyright 2024 Hewlett Packard Enterprise Development LP

# This import must be present for the root level Makefile to function
include ./nats-make.mk

## help: output help for all targets
.PHONY: help
help:
	@echo 'Usage: make [TARGET]'
	@echo 'Targets:'
	@echo
	@grep -h '^## ' $(MAKEFILE_LIST) | column -t -s ':' | sed -e 's/## //'
