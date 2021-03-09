#! /bin/bash
# @edt ASIX M01-ISo Curs 2019-2020
#
# Scripts bàsics
# mostrar l'entrada numerada
# -------------------------------------------------------------------
mes=$1
if [ $mes -lt 1 -o $mes -gt 12 ];
then
	echo "error"
	exit 1
fi
case $mes in
	2)
		echo "28";;
	1|3|5|7|8|10|12)
		echo "31";;
	*)
		echo "30";;
esac
exit 0
