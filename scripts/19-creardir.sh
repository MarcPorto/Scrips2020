#! /bin/bash
# @MarcPorto ASIX 2020-2021
# Març 2021
# [noudir...]
# Validar si existeix 1 o meś argument
# al crear-lo:	si -> stdout
#		no -> stderr
# ordre mkdir no genera sortida
# 
# -----------------------------------------
ERR_NARGS=1

# Validem arguments
if [ $# -eq 0 ]
then
       echo "Error: nº arguments incorrecte"
       echo "Usage: Ha de ser un argument o més"
       exit $ERR_NARGS
fi

for dir in $*
do
	mkdir -p  $dir &> /dev/null
	if  [ $? -eq 0 ] 
	then
		echo $dir

	else
		echo "Error en crear: $dir" >> /dev/stderr
		STATUS=2
	fi
done
exit $STATUS
