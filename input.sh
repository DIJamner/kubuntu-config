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
xkb="/usr/share/X11/xkb"
ctrl_file="symbols/ctrl"
us_file="symbols/us"
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

list-rswap-evdev () {
    grep -q swap_ralt_rctl "$xkb/$evdev"
    if [ $? -eq 1 ]
    then
        echo "Listing swap_ralt_rctl in $xkb/$evdev..."
        sudo sed -i "/^\s*ctrl:swap_lalt_lctl\s*=/r $my_dir/xkb/$evdev" "$xkb/$evdev"
    else
        echo "swap_ralt_rctl found in $xkb/$evdev, skipping...."
    fi
}

# TODO: necessary? if so, fix
list-rswap-evdev-xml () {
    grep -q swap_ralt_rctl "$xkb/$evdevxml"
    if [ $? -eq 1 ]
    then
        echo "Listing swap_ralt_rctl in $xkb/$evdevxml..."
        sed "/^$/r $my_dir/xkb/$evdevxml" "$xkb/$evdevxml"
    else
        echo "swap_ralt_rctl found in $xkb/$evdevxml, skipping...."
    fi
}

keyboard () {
    #TODO set up keybindings, ability to switch to greek easily
    # https://manpages.debian.org/testing/keyboard-configuration/keyboard.5.en.html
    #add-greek
    #set-caps-lock-switch
    #swap-left-ctrl-alt
    
    # TODO: write data to basic/evdev files to register layout variant
    
    list-rswap-evdev
    #list-rswap-evdev-xml
    
    append-if-not-present "$my_dir/xkb/$ctrl_file" "$xkb/$ctrl_file"
    append-if-not-present "$my_dir/xkb/$us_file" "$xkb/$us_file"
    # sets two layouts: us(dustin) and greek
    # resets all options
    # sets caps lock to switch between layouts
    # swaps ctrl and alt for both left and right
    # TODO: set permanently instead of just for session
    setxkbmap -layout us,gr -variant dustin, -option -option "ctrl:swap_ralt_rctl,ctrl:swap_lalt_lctl,grp:caps_toggle"
    # TODO: Ctrl-tab for switching programs (swap with alt-tab?)
    #TODO: Ctrl ~ for switching widnows
    #TODO: consider using caps-lock for one of above
    #keybindings made of alternate layout + alternate shortcuts (maybe?)
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


