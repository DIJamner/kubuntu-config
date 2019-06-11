#! /bin/bash

# TODO: configure key bindings

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
xkb="/usr/share/X11/xkb"
ctrl_file="symbols/ctrl"
us_file="symbols/us"
custom_symbols="symbols/custom"
custom_types="types/custom"
evdev="rules/evdev"
evdevxml="rules/evdev.xml"

#####################
# Utility Functions #
#####################

# helper for appending to a key in a configuration file
kappendconfig5 () {
    local currentval=$(kreadconfig5 $1)
    kwriteconfig5 $1 $currentval,$2
}

# TODO: assert-set

###############
# Setup Steps #
###############

keyboard () {
    
    # move custom layout file into place
    sudo cp "$my_dir/xkb/$custom_symbols" "$xkb/$custom_symbols"
    sudo cp "$my_dir/xkb/$custom_types" "$xkb/$custom_types"
    
    # TODO: make update automatically (rght now, does not update if present)
    # register options in evdev
    append-if-not-present "$my_dir/xkb/$evdev" "$xkb/$evdev"
    
    # sets two layouts: us and greek
    # resets all options
    # sets caps lock to switch between layouts
    # swaps ctrl and alt for both left and right
    # TODO: set permanently instead of just for session
    setxkbmap -layout us,gr -option -option "custom:swap_ralt_rctl_rshift,custom:numpad_arrow_tri,ctrl:swap_lalt_lctl,grp:caps_toggle"
    #keybindings made of alternate layout + alternate shortcuts (maybe?)
    # TODO: change multimedia keys to default vs fn keys (in bios?)
    # TODO: map right shift to alt, right ctrl to alt_gr
    # TODO: map numlk 1 + numlk3 to ctrl+shift+tab, ctrl+tab
}


# ARGUMENTS
# $1 file to append
# $2 file to append to
append-if-not-present () {
    local signature
    read -r signature < $1
    grep -q "$signature" $2
    if [ $? -eq 0 ]
    then 
        echo "Found $1 in file $2. Skipping..."
    else
        echo "Did not find $1 in file $2. Appending to end of file..."
        # TODO: permission denied
        cat $1 | sudo tee -a $2 > /dev/null
    fi
}

trackpad () {
    echo "TODO: implement trackpad settings"
}


keyboard
trackpad


