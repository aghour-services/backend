include .env
PROJECT_NAME ?= aghour

GIT_COMMIT = $(shell git rev-parse HEAD)

SERVER_IMAGE = $(PROJECT_NAME)

DOCKER_REGISTRY ?= registry.magdi.work
SERVER_TAG_NAME = $(DOCKER_REGISTRY)/$(SERVER_IMAGE):$(GIT_COMMIT)
SERVER_TAG_NAME_LATEST = $(DOCKER_REGISTRY)/$(SERVER_IMAGE):latest

export SERVER_IMAGE

export GIT_COMMIT
export SERVER_TAG_NAME


build-server:
	docker build \
	--label "git_commit=$(GIT_COMMIT)" \
	--tag $(SERVER_IMAGE) \
	--file Dockerfile .

tagging:
	docker tag $(SERVER_IMAGE) $(SERVER_TAG_NAME)
	docker tag $(SERVER_IMAGE) $(SERVER_TAG_NAME_LATEST)

push:
	docker push $(SERVER_TAG_NAME)
	docker push $(SERVER_TAG_NAME_LATEST)

build: build-server

up: 
	docker compose up -d

dev: up bash

rollout_server:
	kubectl set image deployment/aghour-backend aghour-backend=$(SERVER_TAG_NAME) -n aghour

rollout: rollout_server

restart:
	docker compose restart

logs:
	docker compose logs -f backend

console:
	docker compose exec backend rails console

sidekiq:
	docker compose exec sidekiq

bash:
	docker compose exec backend bash

db-bash:
	docker compose exec db bash

stop:
	docker compose stop

down:
	docker compose down
