#!/bin/bash

DIR=~/dotfiles

function benderInstall(){
    ln -s "$1" ~/.$(basename  "$1")
    echo "$1 linked"
}


function benderRemove(){
    base=$(basename  "$1")
    rm ~/.$base
    unlink ~/.$base
    echo "~.$base unlinked"
}


function benderInit(){
    for d in $DIR/bundle/*/symlinks/*
    do
        if [[ "$1" == "remove" ]] ; then
            benderRemove "$d"
        else
            benderInstall "$d"
        fi
    done
}

[[ -d $DIR ]] && benderInit "$1"

exit $?
