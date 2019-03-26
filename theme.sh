#! /bin/bash


#SCRIPT RESULT: success

#kwriteconfig5 for writing settings

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
kblayout_opts="$kblayout --key Options"

#####################
# Utility Functions #
#####################


# helper for appending to a key in a configuration file
kappendconfig5 () {
    local currentval=$(kreadconfig5 $1)
    kwriteconfig5 $1 currentval,$2
}

# TODO: assert-set

###############
# Setup Steps #
###############


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
    $my_dir/waitforuser
    rm dracula.kateschema
}

$my_dir/git-setup.sh
kde


