-include .env

DOCKER_REGISTRY := $(or ${DOCKER_REGISTRY},${DOCKER_REGISTRY},docker.io)

pages/tuto-steps/%.html: pages/tuto-steps/%.md
	bundle exec ruby bin/m $< > $@

index.html: pages/index.html
	bundle exec ruby bin/i pages/index.html > index.html

get-our-help.html: pages/get-our-help.html
	bundle exec ruby bin/i pages/get-our-help.html > get-our-help.html

tutorial.html: pages/tutorial.html
	bundle exec ruby bin/i pages/tutorial.html > tutorial.html

extra-goodies.html: pages/extra-goodies.html
	bundle exec ruby bin/i pages/extra-goodies.html > extra-goodies.html

why.html: pages/why.html
	bundle exec ruby bin/i pages/why.html > why.html

tutorial-step-0.html: pages/tutorial/step-0.html pages/tuto-steps/step-0/index.html
	bundle exec ruby bin/i pages/tutorial/step-0.html > tutorial-step-0.html

tutorial-step-1.html: pages/tutorial/step-1.html pages/tuto-steps/step-1/index.html
	bundle exec ruby bin/i pages/tutorial/step-1.html > tutorial-step-1.html

html: index.html get-our-help.html tutorial.html extra-goodies.html why.html tutorial-step-0.html tutorial-step-1.html

index.css: $(shell find style -type f | grep -v ".DS_Store")
	sass style/index.scss > index.css

css: index.css

all: html css

clean:
	rm -rf *.css *.html
	rm -rf Dockerfile.log Dockerfile.built

Dockerfile.built: Dockerfile $(shell find pages -type f | grep -v ".DS_Store")
	docker build -t enspirit/yourbackendisbroken:website .  | tee Dockerfile.log
	touch Dockerfile.built

image: Dockerfile.built

Dockerfile.pushed: Dockerfile.built
	docker tag enspirit/yourbackendisbroken:website $(DOCKER_REGISTRY)/enspirit/yourbackendisbroken:website
	docker push $(DOCKER_REGISTRY)/enspirit/yourbackendisbroken:website
	touch Dockerfile.pushed

push-image: Dockerfile.pushed

run: image
	docker run -p 8080:80 enspirit/yourbackendisbroken

dev:
	docker run -v $$PWD:/usr/share/nginx/html/ -p 8080:80 nginx

hack-image:
	docker build -t enspirit/yourbackendisbroken:website-hack --file Dockerfile.hack .

hack: hack-image
	docker run -it -v $$PWD:/app enspirit/yourbackendisbroken:website-hack bash
