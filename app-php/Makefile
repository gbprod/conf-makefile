.PHONY: help install test-unit

TARGETS:=$(MAKEFILE_LIST)

include ../.env
../.env:
	$(MAKE) --directory=.. .env

COMPOSER_ARGS =
ifeq ($(ENV), prod)
	COMPOSER_ARGS=--prefer-dist --classmap-authoritative --optimize-autoloader --no-dev
endif

ifeq ($(ENV), test)
    COMPOSER_ARGS=--no-interaction
endif

help: ## This help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(TARGETS) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install: vendor ## Install application

vendor: composer.lock
	composer install $(COMPOSER_ARGS)

composer.lock: composer.json
	composer update $(COMPOSER_ARGS)

update: ## Update application
	$(MAKE) --always-make vendor

test-unit: install ## Unit tests
	vendor/bin/phpunit
