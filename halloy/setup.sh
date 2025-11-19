#!/bin/bash

DOTFILESDIR=~/dotfiles

if [ -z "$DOTFILESDIR" ]; then
	echo "DOTFILESDIR var is not set."
	exit 1
fi

if [ -f ~/.config/halloy ]; then
	echo "Found existing ~/.config/halloy. Backing it up..."
	mv ~/.config/halloy ~/.config/halloy-$(date +%F-%R).bak
fi

echo "Soft linking $DOTFILESDIR/halloy to ${HOME}/.config/halloy"
ln -s $DOTFILESDIR/halloy $HOME/.config/halloy

