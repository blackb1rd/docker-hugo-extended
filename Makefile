GIT             = git
DOCKER          = docker
DOCKER_NAME     = hugo-rsync-mozjpeg-node
DOCKER_ACC      = s4m3l0
HUGO_VERSION    = 0.69.1
MOZJPEG_VERSION = 3.3.1
DOCKER_VERSION  = 0
DOCKER_TAG      = v$(HUGO_VERSION).$(DOCKER_VERSION)
DOCKER_IMAGE    = $(DOCKER_ACC)/$(DOCKER_NAME):$(DOCKER_TAG)
DOCKER_RUN      = $(DOCKER) run --rm --interactive --tty --volume $(CURDIR):/src
SASS_BIN        = /usr/local/bin/sass

.PHONY: docker-image docker-push

docker-image:
	$(DOCKER) build \
	--build-arg HUGO_VERSION=$(HUGO_VERSION) \
	--build-arg MOZJPEG_VERSION=$(MOZJPEG_VERSION) . \
	--tag $(DOCKER_IMAGE) \
	--tag $(DOCKER_ACC)/$(DOCKER_NAME):latest \

docker-push:
	$(DOCKER) push $(DOCKER_IMAGE)
	$(DOCKER) push $(DOCKER_ACC)/$(DOCKER_NAME):latest

git-tag-public:
	$(GIT) tag $(DOCKER_TAG)
	$(GIT) push --tags
