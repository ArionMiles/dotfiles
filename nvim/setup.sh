#!/bin/bash

DOTFILESDIR=~/dotfiles


if [ -z "$DOTFILESDIR" ]; then
        echo "DOTFILESDIR var is not set."
        exit 1
fi

if [ -d ~/.config/nvim ]; then
        echo "Creating ~/.config/nvim backup."
        mv ~/.config/nvim ~/.config/nvim-$(date +%F-%R).bak
fi

ln -s $DOTFILESDIR/nvim $HOME/.config/

