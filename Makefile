SHELL := /bin/bash

# set the default region:
AWS_REGION ?= eu-central-1

# set an improbable AWS_PROFILE to avoid mistakenly configured default profile:
AWS_PROFILE ?= 9fed82fc37903ecc5ec2ac73e807aee7

.PHONY: help
help: ## this help
	@echo "Please use 'make <target>' where <target> is one of"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-32s\033[0m %s\n", $$1, $$2}'

update-toc: ## update the table of contents
	doctoc --github README.md
