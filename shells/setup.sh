#!/bin/sh
DOTFILESDIR=~/dotfiles

if [ -f ~/.zshrc ]; then
        echo "Creating .zshrc backup."
        mv ~/.zshrc ~/.zshrc-$(date +%F-%R).bak
fi

if [ -f ~/.zprofile ]; then
        echo "Creating .zprofile backup."
        mv ~/.zshrc ~/.zprofile-$(date +%F-%R).bak
fi


echo "Soft linking .zshrc to ${HOME} directory."
ln -s -v ${DOTFILESDIR}/shells/.zshrc ${HOME}/

echo "Soft linking .zprofile to ${HOME} directory."
ln -s -v ${DOTFILESDIR}/shells/.zprofile ${HOME}/

echo "Soft linking aliases to ${HOME}/.config/aliases"
ln -s -v ${DOTFILESDIR}/shells/aliases ${HOME}/.config/aliases
