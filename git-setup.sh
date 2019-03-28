#! /bin/bash

#exit after an error
set -e

sudo apt install git
git config --global user.email "dijamner@me.com"
git config --global user.name "Dustin Jamner"
# TODO: configure git w/ github and ccs credentials
