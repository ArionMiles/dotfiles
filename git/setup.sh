#!/bin/bash

DOTFILESDIR=~/dotfiles


if [ -z "$DOTFILESDIR" ]; then
	echo "DOTFILESDIR var is not set."
    	exit 1
fi

if [ -f ~/.gitconfig ]; then
	echo "Creating ~/.gitconfig backup."
	mv ~/.gitconfig ~/.gitconfig$(date +%F-%R).bak
fi

ln -s $DOTFILESDIR/git $HOME/.config/

