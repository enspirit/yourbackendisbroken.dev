#!/usr/bin/env bash

sed -i "s/export GEM_HOME.*/export GEM_HOME=\"\/usr\/local\/bundle\"/" $HOME/.bashrc
cp .tutorial/curlrc $HOME/.curlrc
clear
./bin/start
bash
