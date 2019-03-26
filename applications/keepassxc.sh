#! /bin/bash

# Script location
my_dir="$(dirname "$(realpath -s $0)")"

# Script run location
# to make sure relative filepaths passed as arguments are handled correctly
run_loc="$(pwd)"

#############
# Constants #
#############

# Preferences
password_loc="~/Passwords.kdbx"

# install keepassxc and configure with password database and settings
# should be done early to make passwords available to user
# REQUIRED VARS: PASSWORDS
    # TODO:use `` to check if package is installed
if [ "$1" = "setup" ]
then
    # copy over password database
    cd $run_loc
    # TODO: do these work if the application has never been opened?
    # TODO cp $PASSWORDS $password_loc
    # configure keepass settings
    kwriteconfig5 --file keepassxc/keepassxc.ini \
        --group security \
        --key lockdatabaseminimize \
        --type bool \
        true 
    kwriteconfig5 --file keepassxc/keepassxc.ini \
        --group security \
        --key lockdatabaseidle \
        --type bool \
        true 
    kwriteconfig5 --file keepassxc/keepassxc.ini \
        --group security \
        --key lockdatabaseidlesec \
        60 
    kwriteconfig5 --file keepassxc/keepassxc.ini \
        --group General \
        --key LastOpenedDatabases \
        $password_loc
    #TODO: add browser extension?
else
    $my_dir/../utils/aptinstall keepassxc "$0 setup"
fi

