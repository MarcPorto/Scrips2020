#! /bin/bash
# @MarcPorto ASIX 2020-2021
# Febrer 2021
# llistar el directori si existeix
#  $ prog més
# ----------------------------
ERR_NARGS=1
ERR_NORANG=2
# Validem arguments
if [ $# -ne 1 ]
then
	echo "Error: nº arguments incorrecte"
	echo "Usage: $0 dir"
	exit $ERR_NARGS

fi
exit 0

mes=$1
if ! [ $mes -ge 1 -a $mes -le 12]
then
	echo "Error: Argument no vàlid"
	echo "Usage: $0 mes (valor de [1,12]"
	exit $ERR_NORANG

fi
exit 0


case $1 in
	"1"|"3"|"5"|"7"|"8"|"10"|"12")
		echo "té 31 dies";;
	"4"|"6"|"9"|"11")
		echo "té 30 dies";;
	"2")
		echo "té 28 dies";;
	
		
esac
exit 0
