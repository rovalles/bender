#!/bin/bash

DIR=~/dotfiles

function benderInstall(){
    if [ -z "$2" ] ; then
        ln -s "$1" ~/.$(basename  "$1")
    fi
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
            benderRemove "$d" "$2" 
        else
            benderInstall "$d" "$2"
        fi
    done
}

[[ -d $DIR ]] && benderInit "$1" "$2"

exit $?
