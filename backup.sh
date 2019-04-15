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
backup_loc="Vaults/Backups"

cd ~
# TODO: delete old files
rsync -arRvb --backup-dir="../old" --files-from="$targets" ~ "$backup_loc/current"
