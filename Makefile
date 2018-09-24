NGINX_VERSION := 1.15.3
VTS_MODULE_VERSION := v0.1.18

DOCKER_REPO := anhpham1509
DOCKER_IMAGE := nginx-vts-module
GIT_SHA:=$(shell git rev-parse HEAD)

.PHONY: gnu-sed
gnu-sed:
	brew update && brew install gnu-sed

.PHONY: update
update:
	scripts/clone_official_nginx_dockerfile.sh $(NGINX_VERSION)
	scripts/add_vts_module_dockerfile.sh $(VTS_MODULE_VERSION)
	scripts/update_nginx_configurations.sh

.PHONY: build
build:
	docker build . \
		--tag $(DOCKER_REPO)/$(DOCKER_IMAGE):$(GIT_SHA) \
		--tag $(DOCKER_REPO)/$(DOCKER_IMAGE):$(NGINX_VERSION)-$(VTS_MODULE_VERSION) \
		--tag $(DOCKER_REPO)/$(DOCKER_IMAGE):latest \
		--file Dockerfile

.PHONY: run
run:
	docker run $(DOCKER_REPO)/$(DOCKER_IMAGE):$(GIT_SHA) \
		--name nginx-vts \
		-p 8080:80 \
		-d

.PHONY: md-toc
md-toc:
	find . -iname "*.md" -exec markdown-toc --bullets "*" -i {} \;

.PHONY: login
login:
	scripts/ci_docker_login.sh

.PHONY: push
push: login
	scripts/ci_docker_push.sh $(DOCKER_REPO)/$(DOCKER_IMAGE):$(GIT_SHA)
	scripts/ci_docker_push.sh $(DOCKER_REPO)/$(DOCKER_IMAGE):$(NGINX_VERSION)-$(VTS_MODULE_VERSION)
	scripts/ci_docker_push.sh $(DOCKER_REPO)/$(DOCKER_IMAGE):latest
