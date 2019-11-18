#!/usr/bin/env bash

# extracting options and parameters

while [ -n "$1" ]
do
    case "$1" in
        -a) echo "found the -a option";;
        -b) echo "found the -a option";;
        -c) echo "found the -a option";;
        --) shift
            break;;
        *)  echo "$1 is not an option"
    esac
    shift
done

count=1
for parm in $@
do
    echo "Parameter #$count: $param"
    count=$[ $count + 1 ]
done