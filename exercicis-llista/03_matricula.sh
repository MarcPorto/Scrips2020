#! /bin/bash
# edt @Marc Porto
# Programa 2 processa arguments
# curs 2020-21
# 2) Processar els arguments i comptar quantes n’hi ha de 3 o més caràcters.
#-----------------------------------------
num=0
for matricula in "$@"
do
	echo "$matricula" | egrep "^[0-9]{4} [A-Z]{3}$" 2> /dev/null
	if [ $? -ne 0 ]
	then 
		echo "ERROR: $matricula, matricula no vàlida" >> /dev/stderr
		num=$((num+1))
	fi

done
exit $num
