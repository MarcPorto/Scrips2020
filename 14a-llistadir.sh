#! /bin/bash
# @MarcPorto ASIX 2020-2021
# Febrer 2021
# llistar el directori si existeix
# 
# ------------------------------------
ERR_NARGS=1
ERR_NODIR=2
# Validem arguments
if [ $# -ne 1 ]
then
	        echo "Error: nº arguments incorrecte"
	        echo "Usage: $0 dir"
	        exit $ERR_NARGS
fi



#Validar sio existeix el director9i
if  [  ! -d $1 ]
then
       	echo "Error: $mydir no es un directori"
        echo "Usage: $0 dir"
        exit $ERR_NODIR
fi


dir=$1
ls $dir
exit 0

