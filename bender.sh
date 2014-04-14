#!/bin/bash

CMD=$1
COUNT=0
path=""
file=""
so=""
base=""
symLink=""

function install(){
    [ ! -d 'packages' ] && mkdir packages
    cd packages
    git clone $path
    if [ $so ] ; then
        cd $base
        chmod 777 $file
        cd ..
    fi
    cd ..
    ln -s "$(pwd)/packages/$base/$file" $symLink
}

function update(){
    cd packages/$base
    git pull
    cd ../../
}

if [ -a "config.sh" ] ; then
    while read line
    do
        declare -a src=($line)
        path=${src[0]}
        file=${src[1]}
        so=${src[2]}
        symLink=${src[3]}
        base=$(basename $path)
        base=${base%%.*}
        tput setaf 6
        echo $(basename $base)
        tput setaf 7

        $CMD
        COUNT=$((COUNT+1))
        echo ""
    done < "config.sh"
    echo "$COUNT Repos"
else
    echo "config.sh required."
fi

exit $?
