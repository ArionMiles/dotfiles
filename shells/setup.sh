#!/bin/sh
DOTFILESDIR=~/dotfiles

if [ -f ~/.zshrc ]; then
        echo "Creating .zshrc backup."
        mv ~/.zshrc ~/.zshrc$(date +%F-%R).bak
fi

echo "Soft linking .zshrc to ${HOME} directory."
ln -s -v ${DOTFILESDIR}/shells/.zshrc ${HOME}/
