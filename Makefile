ifndef DOCKER_TAG
DOCKER_TAG=0.48
endif

build:
	docker build --build-arg "DOCKER_TAG=${DOCKER_TAG}" -t dkarlovi/docker-hugo:${DOCKER_TAG} .
.PHONY: build
