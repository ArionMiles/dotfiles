#!/usr/bin/env bash

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Create the .zcompdump files under this directory so ~ is clean
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

# Neovim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export EDITOR="nvim"
export VISUAL="nvim"

# Don’t clear the screen after quitting a manual page.
export MANPAGER='less -X'

# Avoid issues with `gpg` as installed via Homebrew.
# https://stackoverflow.com/a/42265848/96656
GPG_TTY=$(tty)
export GPG_TTY

# Prefer US English and use UTF-8.
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8