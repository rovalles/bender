#!/bin/bash

DIR=~/dotfiles

function install(){
    ln -s $1 ~/.$(basename  $1)
    echo "$1 linked"
}


function remove(){
    base=$(basename  $1)
    rm ~/.$base
    unlink ~/.$base
    echo "~/.$base unlinked"
}


function init(){
    for d in $DIR/bundle/*/symlinks/*
    do
        if [[ $b == "-r" ]] ; then
            remove $d
        else
            install $d 
        fi
    done
}

[[ -d $DIR ]] && init $1

exit $?
