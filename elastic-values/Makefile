DOCKER_CMD:=/usr/local/bin/docker
PWD:=$(shell pwd)
DOCKERFILE:=docker/Dockerfile
ESOSS_VERSION:=7.9.1
ESOSS_IMAGE_TAG:=elasticsearch-oss
ESOSS_IMAGE_VER:=$(ESOSS_VERSION)
RELEASE_NAME:=elasticsearch-oss

.PHONY: build-esoss
build-esoss:
	@$(DOCKER_CMD) build -f $(DOCKERFILE) -t $(ESOSS_IMAGE_TAG):$(ESOSS_IMAGE_VER) $(PWD)

.PHONY: push-esoss
push-esoss:
	@$(DOCKER_CMD) tag $(ESOSS_IMAGE_TAG):$(ESOSS_IMAGE_VER) asia.gcr.io/$(project_id)/$(ESOSS_IMAGE_TAG):$(ESOSS_IMAGE_VER) && \
	$(DOCKER_CMD) push asia.gcr.io/$(project_id)/$(ESOSS_IMAGE_TAG):$(ESOSS_IMAGE_VER)

.PHONY: deploy-esoss
deploy-esoss:
	@helm install $(RELEASE_NAME) --values ./values-dev.yaml --version 7.9.3 elastic/elasticsearch

.PHONY: uninstall-esoss
uninstall-esoss:
	@helm uninstall $(RELEASE_NAME)

.PHONY: run-esoss
run-esoss:
	@$(DOCKER_CMD) run --name $(ESOSS_IMAGE_TAG) -d -p 9200:9200 $(ESOSS_IMAGE_TAG):$(ESOSS_IMAGE_VER)

.PHONY: log-esoss
log-esoss:
	@$(DOCKER_CMD) logs $(ESOSS_IMAGE_TAG)

.PHONY: stop-esoss
stop-esoss:
	@$(DOCKER_CMD) stop $(ESOSS_IMAGE_TAG) && \
	$(DOCKER_CMD) rm -v $(ESOSS_IMAGE_TAG)

.PHONY: clean-esoss
clean-esoss:
	@$(DOCKER_CMD) rmi asia.gcr.io/$(project_id)/$(ESOSS_IMAGE_TAG):$(ESOSS_IMAGE_VER)
	@$(DOCKER_CMD) rmi $(ESOSS_IMAGE_TAG):$(ESOSS_IMAGE_VER)
