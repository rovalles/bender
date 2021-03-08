#!/bin/bash

function load(){
    for i in "${LoadScripts[@]}"
    do
        local f="$HOME/dotfiles/bundle/load/$i"
        if [ -f "$f" ] ; then
            . "$f";
        fi
    done
}

function link(){
    for x in "${LinkScripts[@]}"
    do
        local hf="$HOME/.$x"
        local df="$HOME/dotfiles/bundle/symlink/$x"
        if [ ! -e "$hf" ] ; then
            ln -s "$df" "$hf"
        fi
    done
}

load
link
