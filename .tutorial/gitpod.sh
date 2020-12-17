#!/usr/bin/env bash

sed -i "s/export GEM_HOME.*/export GEM_HOME=\"\/usr\/local\/bundle\"/" $HOME/.bashrc
cp .tutorial/.curlrc .tutorial/.vimrc $HOME/
clear
gp preview localhost:8080//tutorial/step-1.html > /dev/null 2>&1 &
./bin/start
bash
