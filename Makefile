GIT              = git
DOCKER           = docker
DOCKER_NAME      = hugo-rsync-node-optimg
DOCKER_ACC       = s4m3l0
HUGO_VERSION     = 0.74.3
MOZJPEG_VERSION  = 3.3.1
PNGQUANT_VERSION = 2.12.1
DOCKER_VERSION   = 1
DOCKER_TAG       = v$(HUGO_VERSION).$(DOCKER_VERSION)
DOCKER_IMAGE     = $(DOCKER_ACC)/$(DOCKER_NAME):$(DOCKER_TAG)
DOCKER_RUN       = $(DOCKER) run --rm --interactive --tty --volume $(CURDIR):/src
SASS_BIN         = /usr/local/bin/sass

.PHONY: docker-image docker-push

docker-image:
	$(DOCKER) build . \
	--tag $(DOCKER_IMAGE) \
	--tag $(DOCKER_ACC)/$(DOCKER_NAME):latest \

docker-push:
	$(DOCKER) push $(DOCKER_IMAGE)
	$(DOCKER) push $(DOCKER_ACC)/$(DOCKER_NAME):latest

release:
	$(GIT) push origin master
	$(GIT) tag $(DOCKER_TAG)
	$(GIT) push --tags
