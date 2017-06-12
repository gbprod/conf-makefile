TARGETS:=$(MAKEFILE_LIST)
DIRS:=$(dir $(wildcard */))

.PHONY: help install test-unit $(DIRS)

include .env
.env:
	@if [ ! -e .env ]; \
		then cp .env.dist .env; \
	fi

help: ## This help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(TARGETS) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: $(DIRS)  ## Install applications

test-unit: $(DIRS) ## Unit tests applications

$(DIRS):
	$(MAKE) --directory=$@ $(MAKECMDGOALS)
