-include .env

DOCKER         ?= docker
DC ?= $(DOCKER) compose

all: up
.PHONY: all

install:
	$(DC) up --remove-orphans -d --build --force-recreate
	make pipelinewise-regenerate-config
.PHONY: install

up:
	$(DC) up -d
.PHONY: up

ps:
	$(DC) ps
.PHONY: ps

recreate:
	$(DC) up -d --force-recreate $(CONTAINER)
.PHONY: recreate

pull:
	$(DC) pull
.PHONY: pull

stop:
	$(DC) stop
.PHONY: stop

down:
	$(DC) down -v --remove-orphans
.PHONY: down

pipelinewise-exec ?= $(DC) exec pipelinewise
pipelinewise-bash ?= $(pipelinewise-exec) bash

pipelinewise-ssh:
	$(pipelinewise-bash)
.PHONY: pipelinewise-ssh

pipelinewise-regenerate-config:
	$(pipelinewise-bash) -c "rm -rf /root/.pipelinewise/*"
	$(pipelinewise-bash) -c "${PIPELINEWISE_HOME}/.virtualenvs/pipelinewise/bin/pipelinewise import --dir ${PIPELINEWISE_HOME}/pipelinewise-config"
.PHONY: pipelinewise-regenerate-config

pipelinewise-status:
	$(pipelinewise-bash) -c "${PIPELINEWISE_HOME}/.virtualenvs/pipelinewise/bin/pipelinewise status"
.PHONY: pipelinewise-status

pipelinewise-run-tap1:
	$(pipelinewise-bash) -c "${PIPELINEWISE_HOME}/.virtualenvs/pipelinewise/bin/pipelinewise run_tap --tap postgres1 --target postgres_dwh"
.PHONY: pipelinewise-run-tap1

pipelinewise-run-tap2:
	$(pipelinewise-bash) -c "${PIPELINEWISE_HOME}/.virtualenvs/pipelinewise/bin/pipelinewise run_tap --tap postgres2 --target postgres_dwh"
.PHONY: pipelinewise-run-tap2

pipelinewise-run-tap3:
	$(pipelinewise-bash) -c "${PIPELINEWISE_HOME}/.virtualenvs/pipelinewise/bin/pipelinewise run_tap --tap postgres3 --target postgres_dwh"
.PHONY: pipelinewise-run-tap3

pipelinewise-run-tap4:
	$(pipelinewise-bash) -c "${PIPELINEWISE_HOME}/.virtualenvs/pipelinewise/bin/pipelinewise run_tap --tap postgres4 --target postgres_dwh"
.PHONY: pipelinewise-run-tap4

pipelinewise-test:
	$(pipelinewise-bash) -c "${PIPELINEWISE_HOME}/sh/tests.sh"
.PHONY: pipelinewise-run-tap4
