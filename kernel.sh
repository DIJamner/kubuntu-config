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

kernel () {
    sudo apt update
    sudo apt upgrade
    # TODO: figure out if actually necessary
    mkdir ~/kernel
    cd ~/kernel
    wget https://kernel.ubuntu.com/~kernel-ppa/mainline/v4.20.8/linux-headers-4.20.8-042008_4.20.8-042008.201902121544_all.deb \\ https://kernel.ubuntu.com/~kernel-ppa/mainline/v4.20.8/linux-headers-4.20.8-042008-generic_4.20.8-042008.201902121544_amd64.deb \\ https://kernel.ubuntu.com/~kernel-ppa/mainline/v4.20.8/linux-headers-4.20.8-042008-lowlatency_4.20.8-042008.201902121544_amd64.deb \\ https://kernel.ubuntu.com/~kernel-ppa/mainline/v4.20.8/linux-image-unsigned-4.20.8-042008-generic_4.20.8-042008.201902121544_amd64.deb \\ https://kernel.ubuntu.com/~kernel-ppa/mainline/v4.20.8/linux-image-unsigned-4.20.8-042008-lowlatency_4.20.8-042008.201902121544_amd64.deb \\ https://kernel.ubuntu.com/~kernel-ppa/mainline/v4.20.8/linux-modules-4.20.8-042008-generic_4.20.8-042008.201902121544_amd64.deb \\ https://kernel.ubuntu.com/~kernel-ppa/mainline/v4.20.8/linux-modules-4.20.8-042008-lowlatency_4.20.8-042008.201902121544_amd64.deb
    sudo dpkg i *.deb
    cd ~
    rm -r ~/kernel
    sudo reboot
}

kernel



