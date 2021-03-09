#! /bin/bash
# @edt ASIX M01-ISo Curs 2019-2020
#
# Scripts bàsics
#   mostrar stdin numerant max lines
# -------------------------------------------------------------------
num=1
MAX=$1
while read -r line
do	
  if [ "$num" -le $MAX ]; then
    echo "$num: $line"
  else
    echo "$line"      	  
  fi	  
  num=$((num+1))
done


