#! /bin/bash
# edt @Marc Porto
# Programa 4 processa stdin
# curs 2020-21
# 4) Processar stdin cmostrant per stdout les línies numerades i en majúscules.
#-----------------------------------------
OK=0
num=0
while read -r line
do
	num=$((num+1))
	echo $num: $line | tr '[:lower:]' '[:upper:]'

done
exit $OK
