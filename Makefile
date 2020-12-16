YBIB_REPO=https://github.com/enspirit/yourbackendisbroken.dev
YBIB_BRANCH=nodejs-tuto

UID := $(shell id -u)
GID := $(shell id -g)

image:
	docker pull enspirit/webspicy
	docker build -t enspirit/yourbackendisbroken . \
		--build-arg YBIB_REPO=${YBIB_REPO} \
		--build-arg YBIB_BRANCH=${YBIB_BRANCH}

start: image
	docker run -it \
		-p 3000:3000 \
		-p 8080:8080 \
		-v ${PWD}:/ybib \
		--user ${UID}:${GID} \
		enspirit/yourbackendisbroken

push-image: image
	docker push enspirit/yourbackendisbroken
