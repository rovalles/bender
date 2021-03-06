#!/bin/bash

function benderAutoload(){
  for file in ~/dotfiles/bundle/*.sh; do
      [ -r "$file" ] && source "$file"
  done
  unset file
}

function benderInstall(){
  local file="$1"
  local link=~/.$(basename  "$file")

  if [ ! -e "$link" ]; then
      ln -sv "$file" "$link"
  else
    echo "$file already linked"
  fi
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

benderAutoload
