#! /bin/bash
# edt @Marc Porto
# Programa 2 processa arguments
# curs 2020-21
# 2) Processar els arguments i comptar quantes n’hi ha de 3 o més caràcters.
#-----------------------------------------
num=0
for arguments in $*
do
	echo $arguments | egrep '.{3,}'
	if [ $? -eq 0 ]
	then 
		num=$((num+1))
	fi


done
echo "$num arguments de 3 o més caràcters"
exit 0
