DOCKER       = docker
DOCKER_NAME  = hugo-rsync-mozjpeg-node
HUGO_VERSION = 0.58.2
DOCKER_ACC   = s4m3l0
DOCKER_TAG   = v$(HUGO_VERSION)
MOZJPEG_VERSION = 3.3.1
DOCKER_IMAGE = $(DOCKER_ACC)/$(DOCKER_NAME):$(DOCKER_TAG)
DOCKER_RUN   = $(DOCKER) run --rm --interactive --tty --volume $(CURDIR):/src
SASS_BIN     = /usr/local/bin/sass

.PHONY: docker-image docker-push

docker-image:
	$(DOCKER) build . \
	--tag $(DOCKER_IMAGE) \
	--build-arg HUGO_VERSION=$(HUGO_VERSION) \
	--build-arg MOZJPEG_VERSION=$(MOZJPEG_VERSION)

docker-push:
	docker push $(DOCKER_IMAGE)
