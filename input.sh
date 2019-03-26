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
xkb="/usr/share/X11/xkb"
ctrl_file="symbols/ctrl"
us_file="symbols/us"

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
    kwriteconfig5 $1 $currentval,$2
}

# TODO: assert-set

###############
# Setup Steps #
###############


keyboard () {
    #TODO set up keybindings, ability to switch to greek easily
    # https://manpages.debian.org/testing/keyboard-configuration/keyboard.5.en.html
    #add-greek
    #set-caps-lock-switch
    #swap-left-ctrl-alt
    
    # TODO: write data to basic/evdev files to register layouts
    append-if-not-present "$my_dir/xkb/$ctrl_file" "$xkcb/$ctrl_file"
    append-if-not-present "$my_dir/xkb/$us_file" "$xkcb/$us_file"
    # sets two layouts: us(dustin) and greek
    # resets all options
    # sets caps lock to switch between layouts
    # swaps ctrl and alt for both left and right
    # TODO: set permanently instead of just for session
    setxkbmap -layout us,gr -variant dustin, -option -option "ctrl:swap_ralt_rctl,ctrl:swap_lalt_lctl,grp:caps_toggle"
    #TODO: Ctrl-tab for switching programs
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
        cat $1 > $2
    fi

}

# adds the greek keyboard layout to the existing layouts
add-greek () {
    kappendconfig5 "$kblayout --key LayoutList" gr
}

# sets caps lock to switch between keyboards
set-caps-lock-switch () {
    # should be equivalent to:
    # setxkbmap -option grp:caps_toggle
    #TODO: which to use?
    kappendconfig5 "$kblayout_opts" grp:caps_toggle
}

swap-left-ctrl-alt () {
    # should be equivalent to:
    # setxkbmap -option ctrl:swap_lwin_lctl
    #TODO: which to use?
    kappendconfig5 "$kblayout_opts" ctrl:swap_lalt_lctl
}

trackpad () {
        
}


#keyboard
trackpad


