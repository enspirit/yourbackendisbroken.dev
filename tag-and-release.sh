#!/bin/bash
##
## Use this script to recreate the tags for the tutorial step
## Usage: ./tag-and-release.sh <sha commit of step 1>
##

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <sha>"
  exit
fi

STEP_1_SHA=$1

if [ ! -z "$(git status --porcelain)" ]; then
  echo "!!! This script can only run on a clean git clone !!!"
  echo ""
  git status
  exit
fi

# Last commit/step
LAST_COMMIT=`git log --reverse --pretty=%H nodejs-tuto | tail -n1`

# Current step
STEP=1

function gitnext {
  CURRENT_COMMIT=`git rev-parse HEAD`
  if [ $CURRENT_COMMIT == $LAST_COMMIT ]; then
    return 1
  fi
  git log --reverse --pretty=%H nodejs-tuto | awk "/$(git rev-parse HEAD)/{getline;print}" | xargs git checkout
}

function gittag {
  git tag -f "step-$STEP"
  STEP=$((STEP+1))
}

# Jump to step 0 commit
git checkout $STEP_1_SHA
gittag $STEP
while gitnext; do
  gittag
done

# Go back to HEAD of branch
git checkout nodejs-tuto
