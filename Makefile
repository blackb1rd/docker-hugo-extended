GIT          = git
DOCKER       = docker
DOCKER_NAME  = hugo-rsync-mozjpeg-node
HUGO_VERSION = 0.58.3
MOZJPEG_VERSION = 3.3.1
NODE_VERSION = 12.12.0
YARN_VERSION = 1.19.1
DOCKER_ACC   = s4m3l0
DOCKER_TAG   = v$(HUGO_VERSION).1
DOCKER_IMAGE = $(DOCKER_ACC)/$(DOCKER_NAME):$(DOCKER_TAG)
DOCKER_RUN   = $(DOCKER) run --rm --interactive --tty --volume $(CURDIR):/src
SASS_BIN     = /usr/local/bin/sass

.PHONY: docker-image docker-push

docker-image:
	$(DOCKER) build . \
	--tag $(DOCKER_IMAGE) \
	--tag $(DOCKER_ACC)/$(DOCKER_NAME):latest \
	--build-arg HUGO_VERSION=$(HUGO_VERSION) \
	--build-arg MOZJPEG_VERSION=$(MOZJPEG_VERSION) \
	--build-arg NODE_VERSION=$(NODE_VERSION) \
	--build-arg YARN_VERSION=$(YARN_VERSION)

docker-push:
	$(DOCKER) push $(DOCKER_IMAGE)
	$(DOCKER) push $(DOCKER_ACC)/$(DOCKER_NAME):latest

git-tag-public:
	$(GIT) tag $(DOCKER_TAG)
	$(GIT) push --tags
