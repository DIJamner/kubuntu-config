#! /bin/bash

#kwriteconfig5 for writing settings
# TODO: add checks for installation
# TODO: configure key bindings
# TODO: mail client

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

# System constants
kblayout="--file kxkbrc --group Layout"
kblayout_opts="$kblayout --key Options"

#####################
# Utility Functions #
#####################

# helper routine to wait for user input
# used when configuration must be done manually
waitforuser () {
    read -p "Press any key to continue... " -n 1 -s
}

# helper for appending to a key in a configuration file
kappendconfig5 () {
    local currentval=$(kreadconfig5 $1)
    kwriteconfig5 $1 currentval,$2
}

# TODO: assert-set

###############
# Setup Steps #
###############



applications () {
    #dropbox
    for script in $my_dir/applications/*.sh
    do
        # TODO: make it work when the scripts are run from here
        "$script"
    done
    # TODO: backups
}

# install keepassxc and configure with password database and settings
# should be done early to make passwords available to user
# REQUIRED VARS: PASSWORDS
# TODO: move to separate scipt and test
keepassxc () {
    # TODO:use `dpkg -l | grep -q $n` to check if package is installed
    sudo apt install keepassxc
    # copy over password database
    cd $run_loc
    # TODO: do these work if the application has never been opened?
    #cp $PASSWORDS $password_loc
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
}

# install and start dropbox
# TODO: move to separate script and test
dropbox () {
    cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    # TODO: wget doesn't give the right file the right name
    wget "https://www.dropbox.com/download?dl=packages/dropbox.py" -o dropbox.py
    chmod +x dropbox.py
    sudo mv dropbox.py /usr/local/bin/dropbox
    dropbox autostart y
    dropbox start
    # USER INPUT
    echo "Log in to dropbox via the browser window"
    $my_dir/../waitforuser
}

applications        



