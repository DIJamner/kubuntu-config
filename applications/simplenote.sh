#! /bin/bash

# ARGUMENTS
# 1 [optional] if this argument is "setup" then just perform setup

# Script location
my_dir="$(dirname "$(realpath -s $0)")"

# Script run location
# to make sure relative filepaths passed as arguments are handled correctly
run_loc="$(pwd)"

if [ "$1" = "setup" ]
then
    simplenote &
    # USER INPUT
    echo "Log in to simplenote"
    echo "Press Cmd+, for preferences -> Display -> Theme. Select Dark."
    $my_dir/../utils/waitforuser
else
    $my_dir/../utils/snapinstall simplenote "$0 setup"
fi

