#!/usr/bin/env bash

####
# three
# trap ' ' signal-list
# trap命令指定一个空命令串,允许忽视信号
###

trap '' SIGINT

count=1

while [ $count -le 10 ]
do
    echo "Loop #$count"
    sleep 5
    count=$[ $count+1 ]
done