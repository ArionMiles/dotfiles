#!/bin/bash

DOTFILESDIR=~/dotfiles


if [ -z "$DOTFILESDIR" ]; then
        echo "DOTFILESDIR var is not set."
        exit 1
fi

if [ -d ~/.config/nvim ]; then
        echo "Found existing ~/.config/nvim config. Backing it up..."
        mv ~/.config/nvim ~/.config/nvim-$(date +%F-%R).bak
fi

echo "Soft linking $DOTFILESDIR/nvim to $HOME/.config/nvim"
ln -s $DOTFILESDIR/nvim $HOME/.config/

