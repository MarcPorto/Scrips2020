#! /bin/bash
# @edt ASIX M01-ISo Curs 2019-2020
#
# Scripts bàsics
#   mostrar l'entrada les línies de +60 chars
# -------------------------------------------------------------------
while read -r line
do	
  num=$(echo "$line" | wc -c)
  if [ "$num" -gt 60 ]; then
    echo $line
  fi	  
done


