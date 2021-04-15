-include .env

DOCKER_COMPOSE ?= docker-compose
DOCKER         ?= docker

all: up
.PHONY: all

up:
	$(DOCKER_COMPOSE) up --remove-orphans -d --build
.PHONY: up

ps:
	$(DOCKER_COMPOSE) ps
.PHONY: ps

recreate:
	$(DOCKER_COMPOSE) up -d --force-recreate $(CONTAINER)
.PHONY: recreate

pull:
	$(DOCKER_COMPOSE) pull
.PHONY: pull

stop:
	$(DOCKER_COMPOSE) stop
.PHONY: stop

down:
	$(DOCKER_COMPOSE) down --remove-orphans
	make db-clean
.PHONY: down

db-clean:
	$(DOCKER) volume rm -f dbt_postgres1
	$(DOCKER) volume rm -f dbt_postgres2
	$(DOCKER) volume rm -f dbt_postgres3
	$(DOCKER) volume rm -f dbt_postgres4
.PHONY: db-clean