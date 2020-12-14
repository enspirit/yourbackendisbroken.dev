#!/bin/bash

clear
echo "Please wait a little bit, the tutorial is loading..."
gp await-port 3000
clear
cat .tutorial/banner.txt
gp open formaldoc/version/get.yml

ttyecho /dev/pts/1 "webspicy formaldoc/config.rb"&
