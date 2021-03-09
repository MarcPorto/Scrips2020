#! /bin/bash
# @edt ASIX M01-ISo Curs 2019-2020
#
# Scripts bàsics
#   mostrar usuaris rebuts per stdin
# -------------------------------------------------------------------
while read -r line
do	
  grep "^$line:" /etc/passwd &> /dev/null
  if [ $? -eq 0 ]; then
    echo $line
  else
    echo $line >> /dev/stderr
  fi	  
done


