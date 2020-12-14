#!/usr/bin/env bash

supervisord
clear

echo "Waiting for API to start..."
timeout 10 bash -c 'until printf "" 2>>/dev/null >>/dev/tcp/$0/$1; do sleep 1; done' localhost 3000

if [ $? -gt 0 ]; then
  echo "API didn't start properly..."
  exit
fi

clear
cat /etc/banner.txt

bash
