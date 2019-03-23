#! /bin/bash

#kwriteconfig5 for writing settings
# TODO: add checks for installation
# TODO: configure key bindings
# TODO: mail client

# Script location
my_dir="$(dirname '$(readlink -f "$0")')"

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

# the entry point of the script
main () {
    # TODO: make the right things autostart
    sudo apt update
    sudo apt upgrade
    keyboard
    git
    kde
    applications
}

keyboard () {
    #TODO set up keybindings, ability to switch to greek easily
    # https://manpages.debian.org/testing/keyboard-configuration/keyboard.5.en.html
    add-greek
    set-caps-lock-switch
    #keybindings made of alternate layout + alternate shortcuts (maybe?)
}

# adds the greek keyboard layout to the existing layouts
add-greek () {
    kappendconfig5 "$kblayout --key LayoutList" gr
}

# sets caps lock to switch between keyboards
set-caps-lock-switch () {
    kappendconfig5 "$kblayout --key Options" grp:caps_toggle
}

git () {
    sudo apt install git
}

# Set up desktop environment and default apps
kde () {
    darkmode
    kate-dracula
    # TODO: put in place/run plasma scripts to set up desktop
}

# switch KDE to dark mode
darkmode () {
    lookandfeeltool --apply org.kde.breezedark.desktop
}

# install the dracula color scheme for Kate
kate-dracula () {
    pushd ~/Downloads
    git clone https://github.com/dracula/kate.git
    mv ./kate/dracula.kateschema dracula.kateschema
    rm -rf ./kate
    kate &
    # USER INPUT
    echo "Go to Settings -> Configure Kate -> Fonts and Colors -> Import."
    echo "Select ~/Downloads/dracula.kateschema. Import as new schema and apply."
    waitforuser
    rm dracula.kateschema
}

applications () {
    keepassxc
    dropbox
    simplenote
    skype
    # TODO: backups
}

# install keepassxc and configure with password database and settings
# should be done early to make passwords available to user
# REQUIRED VARS: PASSWORDS
keepassxc () {
    sudo apt install keepassxc
    # copy over password database
    cd $run_loc
    cp $PASSWORDS $password_loc
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
dropbox () {
    cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    wget "https://www.dropbox.com/packages/dropbox.py"
    chmod +x dropbox.py
    sudo mv dropbox.py /usr/local/bin/dropbox
    dropbox autostart y
    dropbox start
    # USER INPUT
    echo "Log in to dropbox via the browser window"
    waitforuser
}

# install simplenote
simplenote () {
    sudo snap install simplenote
    simplenote &
    # USER INPUT
    echo "Log in to simplenote"
    echo "Press Cmd+, for preferences -> Display -> Theme. Select Dark."
    waitforuser
}

skype () {
    sudo snap install skype --classic
    skype
    echo "Log into Skype"
    echo "Navigate to Settings -> General -> Theme. Select Dark."
    waitforuser

}

main



