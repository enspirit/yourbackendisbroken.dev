YBIB_REPO=https://github.com/enspirit/yourbackendisbroken.dev
YBIB_BRANCH=nodejs-tuto

image:
	docker build -t enspirit/yourbackendisbroken . \
		-f .tutorial/Dockerfile \
		--build-arg YBIB_REPO=${YBIB_REPO} \
		--build-arg YBIB_BRANCH=${YBIB_BRANCH}

start:
	docker run -it \
		-p 3000:3000 \
		-p 8080:80 \
		-v ${PWD}:/ybib \
		enspirit/yourbackendisbroken
