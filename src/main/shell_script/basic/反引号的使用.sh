#!/usr/bin/env bash

# using the backtick character 用反引号括起来的对象会被当作一条命令来执行

testing=`date`

echo "the date and time are : $testing"
