#! /bin/bash


#SCRIPT RESULT: success

# Script location
my_dir="$(dirname "$(realpath -s $0)")"
#exit after an error
set -e

# Script run location
# to make sure relative filepaths passed as arguments are handled correctly
run_loc="$(pwd)"

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
    $my_dir/utils/waitforuser
    rm dracula.kateschema
}

# make sure git is installed so that dracula install works
$my_dir/git-setup.sh
kde


