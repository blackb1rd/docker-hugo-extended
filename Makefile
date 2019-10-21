GIT          = git
DOCKER       = docker
DOCKER_NAME  = hugo-rsync-mozjpeg-node
DOCKER_ACC   = s4m3l0
HUGO_VERSION = 0.58.3
DOCKER_TAG   = v$(HUGO_VERSION).9
DOCKER_IMAGE = $(DOCKER_ACC)/$(DOCKER_NAME):$(DOCKER_TAG)
DOCKER_RUN   = $(DOCKER) run --rm --interactive --tty --volume $(CURDIR):/src
SASS_BIN     = /usr/local/bin/sass

.PHONY: docker-image docker-push

docker-image:
	$(DOCKER) build . \
	--tag $(DOCKER_IMAGE) \
	--tag $(DOCKER_ACC)/$(DOCKER_NAME):latest \

docker-push:
	$(DOCKER) push $(DOCKER_IMAGE)
	$(DOCKER) push $(DOCKER_ACC)/$(DOCKER_NAME):latest

git-tag-public:
	$(GIT) tag $(DOCKER_TAG)
	$(GIT) push --tags
