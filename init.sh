#!/bin/bash

dotfiles="";
if [ -e "$DOTFILES_HOME" ] ; then
  dotfiles="$DOTFILES_HOME"
else
  dotfiles="~/dotfiles"
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


function benderInstall(){
  local file="$1"

  if [ -z "$file" ] ; then
      ln -s "$file" ~/.$(basename  "$file")
  fi
  echo "$file linked"
}


function benderRemove(){
  local file="$1"

  base=$(basename  "$file")
  rm ~/."$base"
  unlink ~/."$base"
  echo "~.$base unlinked"
}


function bender(){
  local cmd="$1"

  for file in $dotfiles/bundle/*/symlinks/*
  do
    if [[ "$cmd" == "remove" ]] ; then
        benderRemove "$file"
    elif [[ "$cmd" == "install" ]] ; then
        benderInstall "$file"
    else
      echo "No idea what command that is."
    fi
  done
}

if [[ -d ~/dotfiles ]]; then
  benderAutoload
  benderBin
fi
