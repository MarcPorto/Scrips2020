#! /bin/bash
# @edt ASIX M01-ISo Curs 2019-2020
#
# Scripts bàsics
# mostrar l'entrada numerada
# -------------------------------------------------------------------
num=1
for arg in $*
do
	echo "$num: $arg"
	num=$((num+1))
done
exit 0
