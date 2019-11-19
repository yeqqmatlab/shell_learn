#!/usr/bin/env bash

###
# two
# trap signal-list
# trap 不指定任何命令,接受信号的默认操作.默认操作是结束进程的运行
###


trap SIGINT

count=1

while [ $count -le 10 ]
do
    echo "Loop #$count"
    sleep 5
    count=$[ $count+1 ]
done