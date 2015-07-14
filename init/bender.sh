#!/bin/bash

dotfiles="$dotfilesPath";
if [ -n "$dotfilesPath" ] ; then
    DIR="$dotfilesPath"
else
    DIR="~/dotfiles/"
fi
function benderAutoload(){
    for file in ~/dotfiles/bundle/*/autoload/*; do
        [ -r "$file" ] && source "$file"
    done
    unset file
}

function benderBin(){
    local scripts=""
    local fileName=""
    for file in ~/dotfiles/bundle/*/bin/*; do
        fileName="$(basename "$file")"
        fileName="${fileName%.*}"
        scripts="alias $fileName=$file;$scripts"
    done
    eval "$scripts"
    unset file
}

benderAutoload
benderBin
