SHELL       := /bin/sh
IMAGE       := psmware/ansible-docker
VERSION     := 1.1

### Executables
DOCKER := docker

### Docker Targets 

.PHONY: build
build: 
	$(DOCKER) build -t $(IMAGE):$(VERSION) --no-cache --rm .

.PHONY: push 
push: 
	$(DOCKER) tag $(IMAGE):$(VERSION) $(IMAGE):latest
	$(DOCKER) push $(IMAGE):$(VERSION)
	$(DOCKER) push $(IMAGE):latest
