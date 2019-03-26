#! /bin/bash

my_dir="$(dirname "$(realpath -s $0)")"

#installs the ful tex distribution
$my_dir/../utils/aptinstall "texlive-full"
$my_dir/../utils/aptinstall "texstudio"
# sudo apt install texlive-full texstudio
# TODO: install texstudio theme
