#!/bin/bash


CMD=$1
COUNT=0


function install(){
    declare -a src=($1)
    local path=${src[0]}
    local file=${src[1]}
    local so=${src[2]}
    local base=$(basename $path)
    local base=${base%%.*}
    echo $(basename $base)
    [ ! -d 'packages' ] && mkdir packages
    cd packages
    git clone $path
    if [ $so ] ; then
        cd $base
        chmod 777 $file
        cd ..
    fi
    cd ..
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
        COUNT=$((count+1))
    done < "config.sh"
    echo $COUNT
else
    echo ""
fi
