#! /bin/bash

# ARGUMENTS
# 1 [optional] if this argument is "setup" then just perform setup

#exit after an error
set -e

# Script location
my_dir="$(dirname "$(realpath -s $0)")"

# Script run location
# to make sure relative filepaths passed as arguments are handled correctly
run_loc="$(pwd)"

if [ "$1" = "setup" ]
then
    skype
    echo 'Log into Skype'
    echo 'Navigate to Tools -> Settings -> General -> Theme. Select Dark.'
    $my_dir/../utils/waitforuser
else
    $my_dir/../utils/snapinstall skype "$0 setup" --classic
fi


