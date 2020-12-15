# Webspicy Tutorial - Step 0

Welcome to this tutorial on black-box API testing with `webspicy`!

There are three main ways to run the tutorial: gitpod, docker, or by cloning our repository. Whatever option you choose, you will need to end up with a shell where the following commands work:

```
curl http://127.0.0.1/api/version
webspicy --help
webspicy http://127.0.0.1/api/version
```

## Use gitpod

We provide a [Gitpod](https://www.gitpod.io/) development environment that runs inside your browser. You don't have to install anything, just click the link below:

[Run webspicy tutorial on Gitpod](https://www.gitpod.io/...)

The tutorial instructions are fully integrated in the gitpod experience, you can close this website and focus on what's happening there.

## Use our docker image

We provide a [Docker](https://docker.io/) image that automatically clones our github repository on your computer and give you a shell to execute `webspicy` commands on an existing (broken) backend written in node.js.

```
mkdir yourbackendisbroken
cd yourbackendisbroken
docker -v $PWD:/yourbackendisbroken run yourbackendisbroken/tutorial
```

Keep a browser open with this website, and the docker shell next to it. Move from step to step as you progress.

## Clone the github repository

The third option is to clone the tutorial repository on github. It requires a bit more work, but is probably closer to what you would need to test your own backend on a developer machine.

First clone the repository from github, then install nodejs (for the backend example) and ruby (for `webspicy` itself):

```
git clone https://github.com/enspirit/yourbackendisbroken.dev
cd yourbackendisbroken.dev
apt-get install nodejs ruby
```

Install the webspicy ruby gem:

```
gem install webspicy
webspicy --help
```

Start the todo API in one terminal to keep an eye on the logs. You will need to restart it if you change the source code:

```
cd todo-api
npm install
npm serve
```

Use webspicy in another terminal as you progress through the tutorial steps on this website.
