#!/bin/sh
DOTFILESDIR=~/dotfiles

if [ -d ~/.tmux/plugins/tpm ]; then
	echo "Tmux plugin manager already exists"
else
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ -f ~/.tmux.conf ]; then
        echo "Found existing ~/.tmux.conf. Backing it up..."
        mv ~/.tmux.conf ~/.tmux.conf-$(date +%F-%R).bak
fi

if [ -f ~/.tmux.remote.conf ]; then
        echo "Found existing ~/.tmux.remote.conf. Backing it up..."
        mv ~/.tmux.remote.conf ~/.tmux.remote.conf-$(date +%F-%R).bak
fi


echo "Soft linking $DOTFILESDIR/tmux/.tmux.conf to ${HOME} directory."
ln -s -v ${DOTFILESDIR}/tmux/.tmux.conf ${HOME}

echo "Soft linking $DOTFILESDIR/tmux/.tmux.remote.conf to ${HOME} directory."
ln -s -v ${DOTFILESDIR}/tmux/.tmux.remote.conf ${HOME}

