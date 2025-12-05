#!/bin/sh
DOTFILESDIR=~/dotfiles

if [ -d ~/.config/tmux/plugins/tpm ]; then
	echo "Tmux plugin manager already exists"
else
	git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

if [ -f ~/.config/tmux.conf ]; then
        echo "Found existing ~/.config/tmux.conf. Backing it up..."
        mv ~/.config/tmux.conf ~/.config/tmux.conf-$(date +%F-%R).bak
fi

if [ -f ~/.config/tmux.remote.conf ]; then
        echo "Found existing ~/.config/tmux.remote.conf. Backing it up..."
        mv ~/.config/tmux.remote.conf ~/.config/tmux.remote.conf-$(date +%F-%R).bak
fi


echo "Soft linking $DOTFILESDIR/tmux/tmux.conf to ${HOME}/.config/tmux directory."
ln -s -v ${DOTFILESDIR}/tmux/tmux.conf ${HOME}/.config/tmux/

echo "Soft linking $DOTFILESDIR/tmux/tmux.remote.conf to ${HOME}/.config/tmux directory."
ln -s -v ${DOTFILESDIR}/tmux/tmux.remote.conf ${HOME}/.config/tmux

