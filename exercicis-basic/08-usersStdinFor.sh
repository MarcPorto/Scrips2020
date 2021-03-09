#! /bin/bash
# @edt ASIX M01-ISo Curs 2019-2020
#
# Scripts bàsics
#   mostrar usuaris rebuts per stdin
# -------------------------------------------------------------------
for user in $*
do	
  grep "^$user:" /etc/passwd &> /dev/null
  if [ $? -eq 0 ]; then
    echo $user
  else
    echo $user >> /dev/stderr
  fi	  
done


