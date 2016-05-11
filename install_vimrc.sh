#!/usr/bin/env bash

ROOT_DIR="$(cd $(dirname "$0"); pwd)/"

if [ -f ~/.vimrc ]; then
    if [[ -L ~/.vimrc ]]; then
        # delete the symbolic link, but not the source file
        rm ~/.vimrc
    else
        # make a backup with the date
        DATE=$(date +%Y-%m-%d_%H_%M_%S)
        NEW_VIMRC=".vimrc-$(date +%Y-%m-%d_%H_%M_%S)"
        mv ~/.vimrc ~/${NEW_VIMRC}
    fi
fi

# link to the file in our repository
ln -s ${ROOT_DIR}/vimrcs/.vimrc ~/

echo "Installed the Vim configuration successfully! Enjoy :-)"
