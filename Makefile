-include .env

pages/tuto-steps/%.html: pages/tuto-steps/%.md
	markdown-it-cli $< > $@

site/index.html: pages/index.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/index.html > site/index.html

site/features.html: pages/features.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/features.html > site/features.html

site/get-our-help.html: pages/get-our-help.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/get-our-help.html > site/get-our-help.html

site/tutorial.html: pages/tutorial.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial.html > site/tutorial.html

site/extra-goodies.html: pages/extra-goodies.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/extra-goodies.html > site/extra-goodies.html

site/why.html: pages/why.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/why.html > site/why.html

site/terms-of-use.html: pages/terms-of-use.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/terms-of-use.html > site/terms-of-use.html

site/privacy-policy.html: pages/privacy-policy.html $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/privacy-policy.html > site/privacy-policy.html

site/tutorial:
	mkdir -p site/tutorial

site/tutorial/step-0.html: pages/tutorial/step-0.html pages/tuto-steps/step-0/index.html site/tutorial $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial/step-0.html > site/tutorial/step-0.html

site/tutorial/step-1.html: pages/tutorial/step-1.html pages/tuto-steps/step-1/index.html site/tutorial $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial/step-1.html > site/tutorial/step-1.html

site/tutorial/step-2.html: pages/tutorial/step-2.html pages/tuto-steps/step-2/index.html site/tutorial $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial/step-2.html > site/tutorial/step-2.html

site/tutorial/step-3.html: pages/tutorial/step-3.html pages/tuto-steps/step-3/index.html site/tutorial $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial/step-3.html > site/tutorial/step-3.html

site/tutorial/step-4.html: pages/tutorial/step-4.html pages/tuto-steps/step-4/index.html site/tutorial $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial/step-4.html > site/tutorial/step-4.html

site/tutorial/step-5.html: pages/tutorial/step-5.html pages/tuto-steps/step-5/index.html site/tutorial $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial/step-5.html > site/tutorial/step-5.html

site/tutorial/step-6.html: pages/tutorial/step-6.html pages/tuto-steps/step-6/index.html site/tutorial $(shell find pages/partials -type f) $(shell find pages/layouts -type f)
	bundle exec ruby bin/i pages/tutorial/step-6.html > site/tutorial/step-6.html

html: site/index.html site/features.html site/get-our-help.html site/tutorial.html site/extra-goodies.html site/why.html site/terms-of-use.html site/privacy-policy.html site/tutorial/step-0.html site/tutorial/step-1.html site/tutorial/step-2.html site/tutorial/step-3.html site/tutorial/step-4.html site/tutorial/step-5.html site/tutorial/step-6.html

site/index.css: $(shell find style -type f | grep -v ".DS_Store")
	sass style/index.scss > site/index.css

site/scripts: $(shell find scripts -type f | grep -v ".DS_Store")
	rm -rf site/scripts
	cp -r scripts site/scripts

site/assets:
	mkdir -p site/assets
	cat assets/circle.svg > site/assets/circle.svg
	cat assets/GitHub-Mark-Light-64px.png > site/assets/GitHub-Mark-Light-64px.png

site: site/tutorial html site/index.css site/assets site/scripts
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
	docker run -p 8081:80 enspirit/yourbackendisbroken:website

dev:
	docker run -v $$PWD/site:/usr/share/nginx/html/ -p 8081:80 nginx

Dockerfile.hack.built: Dockerfile.hack Makefile
	docker build -t enspirit/yourbackendisbroken:website-hack --file Dockerfile.hack .  | tee Dockerfile.hack.log
	touch Dockerfile.hack.built

hack: Dockerfile.hack.built
	docker run -it -v $$PWD:/app enspirit/yourbackendisbroken:website-hack bash
