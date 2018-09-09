SHELL := /bin/bash
APP_ROOT ?= $(shell pwd)
VERSION ?= $(shell cat "$(APP_ROOT)/VERSION")
TRAVIS_JOB_NUMBER ?= $(VERSION)
TAG ?= $(VERSION).$(TRAVIS_JOB_NUMBER)
DOCKER_USERNAME ?= $(shell git config --get user.email | sed 's/\(.*\)@\(.*\)/\1/')
DOCKER_IMAGE ?= traviscli

.PHONY: build tag push
default: build

build:
	docker build --build-arg DOCKER_IMAGE="$(DOCKER_IMAGE)" --build-arg TAG="$(TAG)" -t $(DOCKER_IMAGE):$(TAG) .

tag:
	docker tag $(DOCKER_IMAGE):$(TAG) $(DOCKER_USERNAME)/$(DOCKER_IMAGE):$(TAG)

push:
	docker push $(DOCKER_USERNAME)/$(DOCKER_IMAGE):$(TAG)
