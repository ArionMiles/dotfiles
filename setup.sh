#!/bin/bash

DOTFILESDIR=~/dotfiles

if [ -z "$DOTFILESDIR" ]; then
        echo "DOTFILESDIR var is not set."
        exit 1
fi

function exit_if_failed{
    echo "# ERROR # Exiting.."
    echo 1>&2 "failed with $?"
    exit 1
}

for f in */setup.sh; do
    bash $f | exit_if_failed
done
