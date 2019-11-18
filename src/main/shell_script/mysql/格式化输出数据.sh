#!/usr/bin/env bash

MYSQL=`which mysql`
dbs=`$MYSQL -uroot -proot -D test -Bse 'show tables;'`
for db in $dbs
do
    echo $db
done

# 用xml输出数据
mysql -h localhost -P 3306 -uroot -proot -D test -X -e 'select *  from tb_student'

# 使用table标签输出数据
mysql -h localhost -P 3306 -uroot -proot -D test -H -e 'select *  from tb_student'
