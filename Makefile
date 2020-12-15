-include .env

pages/tuto-steps/%.html: pages/tuto-steps/%.md
	markdown-it-cli $< > $@

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

site/tutorial:
	mkdir -p site/tutorial

site/tutorial/step-0.html: pages/tutorial/step-0.html pages/tuto-steps/step-0/index.html site/tutorial $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial/step-0.html > site/tutorial/step-0.html

site/tutorial/step-1.html: pages/tutorial/step-1.html pages/tuto-steps/step-1/index.html site/tutorial $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial/step-1.html > site/tutorial/step-1.html

html: site/index.html site/get-our-help.html site/tutorial.html site/extra-goodies.html site/why.html site/tutorial/step-0.html site/tutorial/step-1.html

site/index.css: $(shell find style -type f | grep -v ".DS_Store")
	sass style/index.scss > site/index.css

css: site/index.css

site: site/tutorial html css
all: site

clean:
	rm -rf *.css *.html site/* pages/tuto-steps/**/*.html
	rm -rf Dockerfile.log Dockerfile.built Dockerfile.pushed

check:
	grep --color -Rn href pages  | grep -v page_prefix | grep -v http | grep -v mailto | grep -v 'href="#' | grep -v 'href="step' | grep href

Dockerfile.built: Dockerfile Makefile $(shell find pages style -type f | grep -v ".DS_Store")
	docker build -t enspirit/yourbackendisbroken:website .  | tee Dockerfile.log
	touch Dockerfile.built

image: Dockerfile.built

Dockerfile.pushed: Dockerfile.built
	docker push enspirit/yourbackendisbroken:website
	touch Dockerfile.pushed

push-image: Dockerfile.pushed

run: image
	docker run -p 8080:80 enspirit/yourbackendisbroken:website

dev:
	docker run -v $$PWD/site:/usr/share/nginx/html/ -p 8080:80 nginx

Dockerfile.hack.built: Dockerfile.hack Makefile
	docker build -t enspirit/yourbackendisbroken:website-hack --file Dockerfile.hack .  | tee Dockerfile.hack.log
	touch Dockerfile.hack.built

hack: Dockerfile.hack.built
	docker run -it -v $$PWD:/app enspirit/yourbackendisbroken:website-hack bash
