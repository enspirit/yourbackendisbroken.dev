# Developer... Your backend is broken.

Whilst continuously worked on software for many years, we've come to the conclusion that many teams could improve the quality of their software through better design and black-box testing of backend components.

This repository contains the source code of https://yourbackendisbroken.deb/, both the website and the tutorial.

The black-box testing technology `webspicy` is hosted at https://github.com/enspirit/webspicy

## Git organization

The repository is organized as independent branches:

- `master`: just this README
- `nodejs-tuto`: the source code of the tutorial based on a TODO list broken backend, written in node.js
- `website`: the source code the website itself.

Each branch has its own README & build chain, please check them if you plan to contribute.

## Docker images

The following docker images are built by this repository:

* `enspirit/yourbackendisbroken` our interactive tutorial
* `enspirit/yourbackendisbroken:website` for the website hosted at https://yourbackendisbroken.dev
* `enspirit/yourbackendisbroken:htmltuto` reusable image with the static html pages for the tutorial

These images are NOT intended to be used for running webspicy itself on your own backend. Please refer to https://github.com/enspirit/webspicy and use `enspirit/webspicy` docker images instead.

## Licence

[![CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg)](http://creativecommons.org/licenses/by/4.0/)

This yourbackendisbroken.dev tutorial and website is licensed under a
[Creative Commons Attribution 4.0 International License](http://creativecommons.org/licenses/by/4.0/).

## Contributing

* Open a github issue for simple questions.
* Please use github pull requests with proposed improvements.
* We are also open to discussion by email at info@yourbackendisbroken.dev

## Contributors

* Bernard Lambeau (@blambeau)
* Felix Holmgren (@felixyz)
* Louis Lambeau (@llambeau)
* Yoann Guyot (@ygu)
