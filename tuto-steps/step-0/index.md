# Webspicy Tutorial - Step 0

Welcome to this tutorial on black-box API testing with `webspicy`!

There are three main ways to run the tutorial: Gitpod, docker, or by cloning our repository. Whatever option you choose, you will need to end up with a shell where the following commands work:

```
$ curl http://127.0.0.1:3000/version
$ webspicy --help
```

## Use gitpod

We provide a [Gitpod](https://www.gitpod.io/) development environment that runs inside your browser. You don't have to install anything, just click the link below:

The tutorial instructions are fully integrated in the Gitpod experience:

[![Run tutorial on Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/enspirit/yourbackendisbroken.dev/tree/nodejs-tuto)

## Use our docker image

We provide a [Docker](https://docker.io/) image that automatically clones our github repository on your computer and give you a shell to execute `webspicy` commands on an existing (broken) backend written in node.js.

```
$ mkdir yourbackendisbroken
$ cd yourbackendisbroken
$ docker run -it --pull-always \
  -p 3000:3000 \
  -p 8080:80 \
  -v $PWD:/ybib \
  enspirit/yourbackendisbroken
```

After running the command, you should be greeted by `webspicy`. The tutorial is now running on http://127.0.0.1:8080/, where some API logs are also served.

## Clone the github repository

The third option is to clone the tutorial repository on github. It requires a bit more work, but is probably closer to what you would need to test your own backend on a developer machine.

First clone the repository from github then install nodejs (for the backend example) and ruby (for `webspicy` itself):

```
$ git clone https://github.com/enspirit/yourbackendisbroken.dev
$ cd yourbackendisbroken.dev
$ apt-get install nodejs ruby
```

Install the webspicy ruby gem:

```
$ gem install webspicy
$ webspicy --help
```

Start the todo API in one terminal to keep an eye on the logs. The API will automatically restart if you change the source code:

```
$ cd todo-api
$ npm install
$ npm start
```

Use `webspicy` in another terminal as you progress in the tutorial steps on this website.

You are ready to start the tutorial, just run

```
bin/start
```
