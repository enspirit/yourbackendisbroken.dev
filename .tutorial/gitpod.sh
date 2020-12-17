#!/usr/bin/env bash

sed -i "s/export GEM_HOME.*/export GEM_HOME=\"\/usr\/local\/bundle\"/" $HOME/.bashrc
cp .tutorial/curlrc $HOME/.curlrc
clear
gp preview localhost:8080//tutorial/step-1.html&
./bin/start
bash
