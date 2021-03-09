#! /bin/bash
#EDT Mati Vizcaino
#Programa 1 processa arguments
#curso 2018 2019
# 1) Processar els arguments i mostrar per stdout només els de 4 o més caràcters
#-----------------------------------------

for arguments in $*
do
	echo $arguments | egrep '.{4,}'


done
exit 0
