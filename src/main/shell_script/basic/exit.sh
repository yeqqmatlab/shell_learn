#!/usr/bin/env bash

# 退出状态码，最大为255，超过则进行摸运算

var1=10
var2=50
var3=$[$var1 + $var2]
echo The answer is $[var3]
exit 1
