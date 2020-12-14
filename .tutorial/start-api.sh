#!/bin/sh

# Local Docker
if [ -z "$GITPOD_REPO_ROOT" ]; then
  cd /ybib/todo-api
else
  cd $GITPOD_REPO_ROOT/todo-api;
fi

npm run start:frontail
