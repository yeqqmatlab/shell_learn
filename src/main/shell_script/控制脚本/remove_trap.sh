#!/usr/bin/env bash

trap "echo byebye" EXIT

count=1
while [ $count -le 5 ]
do
    echo "loop #$count"
    sleep 2
    count=$[ $count + 1 ]
done
# removing trap
trap - EXIT
echo "I just removed the trap"
