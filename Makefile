-include .env

DOCKER_COMPOSE ?= docker-compose
DOCKER         ?= docker

all: up
.PHONY: all

install:
	$(DOCKER_COMPOSE) up --remove-orphans -d --build
.PHONY: install

up:
	$(DOCKER_COMPOSE) up -d
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
	$(DOCKER_COMPOSE) down -v --remove-orphans
.PHONY: down
