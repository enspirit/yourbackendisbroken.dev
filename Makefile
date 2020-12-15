-include .env

DOCKER_REGISTRY := $(or ${DOCKER_REGISTRY},${DOCKER_REGISTRY},docker.io)

index.html: pages/* pages/partials/* pages/layouts/*
	bin/i pages/index.html > index.html

get-our-help.html: pages/* pages/partials/* pages/layouts/*
	bin/i pages/get-our-help.html > get-our-help.html

tutorial.html: pages/* pages/partials/* pages/layouts/*
	bin/i pages/tutorial.html > tutorial.html

tutorial-step-1.html: pages/* pages/partials/* pages/layouts/* pages/tutorial/*
	bin/i pages/tutorial/step-1.html > tutorial-step-1.html

extra-goodies.html: pages/* pages/partials/* pages/layouts/*
	bin/i pages/extra-goodies.html > extra-goodies.html

why.html: pages/* pages/partials/* pages/layouts/*
	bin/i pages/why.html > why.html

html: index.html get-our-help.html tutorial.html extra-goodies.html why.html tutorial-step-1.html

index.css: style/* style/shared/* style/pages/*
	sass style/index.scss > index.css

css: index.css

all: html css

clean:
	rm -rf *.css *.html
	rm -rf Dockerfile.log Dockerfile.built

Dockerfile.built: Dockerfile pages/* pages/partials/* pages/layouts/* style/* style/pages/* style/shared/* scripts/*
	docker build -t enspirit/yourbackendisbroken .  | tee Dockerfile.log
	touch Dockerfile.built

image: Dockerfile.built

Dockerfile.pushed: Dockerfile.built
	docker tag enspirit/yourbackendisbroken $(DOCKER_REGISTRY)/enspirit/yourbackendisbroken
	docker push $(DOCKER_REGISTRY)/enspirit/yourbackendisbroken
	touch Dockerfile.pushed

push-image: Dockerfile.pushed

run: image
	docker run -p 8080:80 enspirit/yourbackendisbroken

dev:
	docker run -v $$PWD:/usr/share/nginx/html/ -p 8080:80 nginx

hack-image:
	docker build -t enspirit/yourbackendisbroken-hack --file Dockerfile.hack .

hack: hack-image
	docker run -it -v $$PWD:/app enspirit/yourbackendisbroken-hack bash

tuto-steps/%.html: tuto-steps/%.md
	bin/m $< > $@
