-include .env

DOCKER_REGISTRY := $(or ${DOCKER_REGISTRY},${DOCKER_REGISTRY},docker.io)

clean:
	rm -rf Dockerfile.log Dockerfile.built

Dockerfile.built: index.html Dockerfile
	docker build -t enspirit/yourbackendisbroken .  | tee Dockerfile.log
	touch Dockerfile.built

image: Dockerfile.built

Dockerfile.pushed: Dockerfile.built
	docker tag enspirit/yourbackendisbroken $(DOCKER_REGISTRY)/enspirit/yourbackendisbroken
	docker push $(DOCKER_REGISTRY)/enspirit/yourbackendisbroken
	touch Dockerfile.pushed

push-image: Dockerfile.pushed
