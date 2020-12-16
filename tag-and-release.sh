#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <sha>"
  exit
fi

STEP_0_SHA=$1

if [ ! -z "$(git status --porcelain)" ]; then
  echo "!!! This script can only run on a clean git clone !!!"
  echo ""
  git status
  exit
fi

# Last commit/step
LAST_COMMIT=`git log --reverse --pretty=%H nodejs-tuto | tail -n1`

# Current step
STEP=0

function gitnext {
  CURRENT_COMMIT=`git rev-parse HEAD`
  if [ $CURRENT_COMMIT == $LAST_COMMIT ]; then
    return 1
  fi
  git log --reverse --pretty=%H nodejs-tuto | awk "/$(git rev-parse HEAD)/{getline;print}" | xargs git checkout
}

function gittag {
  STEP=$((STEP+1))
  git tag -f "step-$1"
}

# Jump to step 0 commit
git checkout $STEP_0_SHA
gittag $STEP
while gitnext; do
  gittag $STEP
done
