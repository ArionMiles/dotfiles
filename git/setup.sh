#!/bin/bash

DOTFILESDIR=~/dotfiles

if [ -z "$DOTFILESDIR" ]; then
	echo "DOTFILESDIR var is not set."
    	exit 1
fi

if [ -f ~/.gitconfig ]; then
	echo "Found existing ~/.gitconfing. Backing it up...
	mv ~/.gitconfig ~/.gitconfig-$(date +%F-%R).bak
fi

echo "Soft linking $DOTFILESDIR/git to $HOME/.config/git"
ln -s $DOTFILESDIR/git $HOME/.config/

