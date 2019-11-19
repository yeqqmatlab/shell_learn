#!/usr/bin/env bash

###
# one
# trap "commands" signal-list 信号列表
# 当脚本收到signal-list清单内列出的信号时,trap命令执行双引号中的命令
###

trap "echo 'Sorry! I have trapped Ctrl-C'" SIGINT SIGTERM

echo 'this is a test program'

count=1

while [ $count -le 10 ]
do
    echo "Loop #$count"
    sleep 5
    count=$[ $count+1 ]
done