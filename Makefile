ENV = /usr/bin/env
DOCKER_BUILDKIT ?= 1
DOCKER ?= docker
DOCKERFILE_PATH ?= .
IMAGE_NAME ?= $(shell basename "${DOCKERFILE_PATH}")
IMAGE_ID ?= $(shell echo "docker.pkg.github.com/$GITHUB_REPOSITORY/$IMAGE_NAME")
DOCKER_REPO ?= docker.pkg.github.com
DOCKER_USERNAME ?= ${GITHUB_ACTOR}
DOCKER_PASSWORD ?= ${GITHUB_TOKEN}
IMAGE_VERSION ?= $(shell test -f ${DOCKERFILE_PATH}/VERSION && cat ./${DOCKERFILE_PATH}/VERSION)

.SHELLFLAGS = -c # Run commands in a -c flag 

.SILENT: ;               # no need for @
.ONESHELL: ;             # recipes execute in same shell
.NOTPARALLEL: ;          # wait for this target to finish
.EXPORT_ALL_VARIABLES: ; # send all vars to shell

.PHONY: all # All targets are accessible for user
.DEFAULT: help # Running Make will run the help target

help: ## Show help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

login: ## Login to docker registry
	echo "$(DOCKER_PASSWORD)" | docker login $(DOCKER_REPO) -u $(DOCKER_USERNAME) --password-stdin

build: ## Build docker image
	$(DOCKER) build -t $(IMAGE_NAME) -f $(DOCKERFILE_PATH)/Dockerfile ./$(IMAGE_NAME)/

tag: ## Tag image witg version image version
	$(DOCKER) tag $(IMAGE_NAME) $(IMAGE_ID):$(IMAGE_VERSION)

publish: login build tag ## Build and publish image with image version
	$(DOCKER) push $(IMAGE_NAME) $(IMAGE_ID):$(IMAGE_VERSION)

tag-latest: ## Tag latest image
	$(DOCKER) tag $(IMAGE_NAME) $(IMAGE_ID):latest

publish-latest: publish tag-latest ## Build and publish image with image version and latest tab
	$(DOCKER) push $(IMAGE_NAME) $(IMAGE_ID):latest

