.PHONY: help install update test-unit start

TARGETS:=$(MAKEFILE_LIST)
RUNNING:=`docker ps -q --filter status=running --filter name=^/web-2$$`

help: ## This help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(TARGETS) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

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

install: docker-compose.yml start vendor ## Install application

start: # Start application
	@if [ ! "$(RUNNING)" ]; then \
		docker-compose up -d --no-recreate; \
	fi

stop: # Stop application
	@if [ "$(RUNNING)" ]; then \
		docker-compose stop; \
	fi

docker-compose.yml: docker-compose.yml.dist
	cp docker-compose.yml.dist docker-compose.yml
	docker-compose up -d

vendor: composer.lock
	$(call execute, composer install $(COMPOSER_ARGS))

composer.lock: composer.json
	$(call execute, composer update $(COMPOSER_ARGS))

update: ## Update application
	$(MAKE) --always-make vendor

test-unit: install ## Unit tests
	$(call execute, vendor/bin/phpunit)

ifeq ($(DOCKER), true)
define execute
    docker exec -it web-2 sh -c "$(1)"
endef
else
define execute
    $(1)
endef
endif

