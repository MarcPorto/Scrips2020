#! /bin/bash
# @edt ASIX M01-ISo Curs 2019-2020
#
# Scripts bàsics
# mostrar l'entrada numerada
# -------------------------------------------------------------------
num=0
MAX="$1"
while [ $num -le $MAX ]
do
	echo "$num"
	num=$((num+1))
done
exit 0
