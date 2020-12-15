-include .env

pages/tuto-steps/%.html: pages/tuto-steps/%.md
	bundle exec ruby bin/m $< > $@

site/index.html: pages/index.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/index.html > site/index.html

site/get-our-help.html: pages/get-our-help.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/get-our-help.html > site/get-our-help.html

site/tutorial.html: pages/tutorial.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial.html > site/tutorial.html

site/extra-goodies.html: pages/extra-goodies.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/extra-goodies.html > site/extra-goodies.html

site/why.html: pages/why.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/why.html > site/why.html

site/tutorial/step-0.html: pages/tutorial/step-0.html pages/tuto-steps/step-0/index.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial/step-0.html > site/tutorial/step-0.html

site/tutorial-step-1.html: pages/tutorial/step-1.html pages/tuto-steps/step-1/index.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial/step-1.html > site/tutorial/step-1.html

html: site/index.html site/get-our-help.html site/tutorial.html site/extra-goodies.html site/why.html site/tutorial/step-0.html site/tutorial/step-1.html

index.css: $(shell find style -type f | grep -v ".DS_Store")
	sass style/index.scss > site/index.css

css: site/index.css

site: html css

clean:
	rm -rf *.css *.html site/*
	rm -rf Dockerfile.log Dockerfile.built Dockerfile.pushed

Dockerfile.built: Dockerfile
	docker build -t enspirit/yourbackendisbroken:website .  | tee Dockerfile.log
	touch Dockerfile.built

image: Dockerfile.built

Dockerfile.pushed: Dockerfile.built
	docker push enspirit/yourbackendisbroken:website
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
