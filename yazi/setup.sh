#!/bin/bash

DOTFILESDIR=~/dotfiles

if [ -z "$DOTFILESDIR" ]; then
        echo "DOTFILESDIR var is not set."
        exit 1
fi

if [ -d ~/.config/yazi ]; then
        echo "Found existing ~/.config/yazi. Backing it up..."
        mv ~/.gitconfig ~/.config/yazi-$(date +%F-%R).bak
fi

echo "Soft linking $DOTFILESDIR/yazi to $HOME/.config/yazi"
ln -s $DOTFILESDIR/yazi $HOME/.config/
