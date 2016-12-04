#!/bin/bash

# Bash strict mode
set -euo pipefail

# Verbose
#set -x

HOMEDIR=~

package() {
    sudo apt-get -y install "$@"
}

init() {
    # Set the user's password to ubuntu
    echo 'ubuntu:ubuntu' | sudo chpasswd

    # Add sage repo
    sudo apt-add-repository -y ppa:aims/sagemath

    # Add 32-bit arch to dpkg
    sudo dpkg --add-architecture i386

    # Updates
    sudo apt-get -y update
    sudo apt-get -y upgrade

    # Install packages
    package \
        build-essential \
        emacs vim \
        git \
        python-pip python3-pip \
        python2.7 python2.7-dev libssl-dev libffi-dev \
        tmux \
        gdb gdb-multiarch \
        unzip \
        p7zip p7zip-rar \
        ipython ipython3 \
        xfce4

    pip install --upgrade pip

    # Install 32 bit libs
    package \
        libc6:i386 libncurses5:i386 libstdc++6:i386 \
        libc6-dbg libc6-dbg:i386 \
        libc6-dev-i386

    # Fix urllib3 InsecurePlatformWarning
    sudo -H pip install --upgrade urllib3[secure]
}

# Only install if script is being executed, not sourced
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    set -e

    init

    package \
        foremost \
        binwalk \
        autopsy \
        sleuthkit \
        volatility \
        steghide \
        pngcheck \
        libimage-exiftool-perl \
        sagemath-upstream-binary

    pip install Pillow
fi
