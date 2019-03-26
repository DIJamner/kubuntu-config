#! /bin/bash

# TODO: mail client

# Script location
my_dir="$(dirname "$(realpath -s $0)")"

# Script run location
# to make sure relative filepaths passed as arguments are handled correctly
run_loc="$(pwd)"

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



