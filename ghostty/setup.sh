#!/bin/bash

DOTFILESDIR=~/dotfiles

if [ -z "$DOTFILESDIR" ]; then
        echo "DOTFILESDIR var is not set."
        exit 1
fi

if [ -f ~/.config/ghostty ]; then
        echo "Found existing ~/.config/ghostty. Backing it up..."
        mv ~/.config/ghostty ~/.config/ghostty-$(date +%F-%R).bak
fi

echo "Soft linking $DOTFILESDIR/ghostty to ${HOME}/.config/ghostty"
ln -s $DOTFILESDIR/ghostty $HOME/.config/ghostty
