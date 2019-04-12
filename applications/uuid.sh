#! /bin/bash

# Script location
my_dir="$(dirname "$(realpath -s $0)")"

# Script run location
# to make sure relative filepaths passed as arguments are handled correctly
run_loc="$(pwd)"


# import fn tools
source "$my_dir/../utils/fn.sh"

uuid-install () {
    echo "Calling setup!"

}

$my_dir/../utils/aptinstall uuid $(pass uuid-install)

