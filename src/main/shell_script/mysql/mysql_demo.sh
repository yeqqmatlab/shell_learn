#!/usr/bin/env bash


echo "0==}=========> Are you sure to continue? yes/no"
read option
if [ "$option" == "yes" ]; then
  echo You made a good choice.
  echo ----------
elif [ "$option" == "no" ];then
  echo Goodbye~
  exit 0
else
  echo PLASE INPUT yes OR no THEN TRY AGAIN!
  exit 0
fi

# to call SQL statement at MySQL prompt
mysql -h localhost -P 3306 -u root -proot -D test <<EOF
select current_date();
use test;
desc tb_student;
select count(*) from tb_student;
insert into tb_student values("python","it",90);

EOF