#! /bin/bash

#exit after an error
set -e

# Script location
my_dir="$(dirname "$(realpath -s $0)")"

# Script run location
# to make sure relative filepaths passed as arguments are handled correctly
run_loc="$(pwd)"

#############
# Constants #
#############

# Preferences
targets="backup_targets.txt"

cd ~
# TODO: delete old files
rsync -arRv --files-from="$targets" ~ ~/Vaults/Backups/current
