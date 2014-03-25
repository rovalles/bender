#!/bin/bash


CMD=$1
COUNT=0


function install(){
    declare -a src=($1)
    local path=${src[0]}
    local file=${src[1]}
    local so=${src[2]}
    [ ! -d 'packages' ] && mkdir packages
    cd packages
    git clone $path
}

function uninstall(){
    echo "uninstall"
}

function unupdate(){
    echo "unupdate"
}

if [ -a "config.sh" ] ; then
    while read line
    do
        $CMD "$line"
    done < "config.sh"
else
    echo ""
fi
