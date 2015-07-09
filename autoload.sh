#!/bin/bash
for file in ~/dotfiles/bundle/*/autoload/*; do
    [ -r "$file" ] && source "$file"
done
unset file
