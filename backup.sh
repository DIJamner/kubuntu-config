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
backup_loc="/media/dustin/SD_CARD/Backups"

function do-backup () {
    rsync -arRvb --backup-dir="../old" --files-from="$targets" ~ "$backup_loc/current"
}

cd ~

# check that backups exist
if [ -e "$backup_loc/current" ]
then
    do-backup
elif [ "$1" = "--new" ]
then
    do-backup
else 
    echo "No backup found. Use '--new' to create a new backup"
fi
