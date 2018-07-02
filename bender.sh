#!/bin/bash

if [ ! -d "$DOTFILES_HOME" ] ; then
  export DOTFILES_HOME=~/dotfiles
fi

dotfiles="$DOTFILES_HOME"

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

# function benderCheck(){
#   local file="$1"

#   if [ -L $("$dotfiles$(basename $file)") ]  ; then
#     echo "$file linked"
#   fi
# }

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
    # elif [[ "$cmd" == "check" ]] ; then
    #     benderCheck "$file"
    else
      echo "No idea what command that is."
    fi
  done
}

if [[ -d "$DOTFILES_HOME" ]]; then
  benderAutoload
  benderBin
fi
