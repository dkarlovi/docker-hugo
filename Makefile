ifndef DOCKER_TAG
DOCKER_TAG=$(shell curl --silent "https://api.github.com/repos/gohugoio/hugo/releases/latest" | jq -r ' .tag_name' | cut -c 2-10)
endif

build:
	docker build --build-arg "DOCKER_TAG=${DOCKER_TAG}" -t dkarlovi/hugo:${DOCKER_TAG} .
.PHONY: build
