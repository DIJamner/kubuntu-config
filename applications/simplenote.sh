#! /bin/bash

#kwriteconfig5 for writing settings
# TODO: add checks for installation

# Script location
my_dir="$(dirname '$(readlink -f "$0")')"

# Script run location
# to make sure relative filepaths passed as arguments are handled correctly
run_loc="$(pwd)"

user-setup () {
    simplenote &
    # USER INPUT
    echo "Log in to simplenote"
    echo "Press Cmd+, for preferences -> Display -> Theme. Select Dark."
    $my_dir/waitforuser
}

$my_dir/utils/snapinstall simplenote user-setup


