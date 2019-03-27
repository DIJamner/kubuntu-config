#! /bin/bash

# Script location
my_dir="$(dirname "$(realpath -s $0)")"

# Script run location
# to make sure relative filepaths passed as arguments are handled correctly
run_loc="$(pwd)"


# TODO: make the right things autostart
# TODO: automate script discovery
sudo apt update
sudo apt upgrade
$my_dir/input.sh
$my_dir/git-setup.sh
$my_dir/theme.sh
$my_dir/applications.sh



