#! /bin/bash
# @MarcPorto ASIX 2020-2021
# Febrer 2021
# 
# 
# ------------------------------------
ERR_NARGS=1
ERR_NOEXIST=2
ERR_NODIR=3
# Validem arguments
if [ $# -ne 2 ]
then
	echo "Error: nº arguments incorrecte"
	echo "Usage: $0 dir"
	exit $ERR_NARGS
fi


# Validem si existeix el file
if  [ ! -e $1 ]; 
then
	echo "ERROR: $1 no existeix"
	echo "Usage:..."
	exit $ERR_NOEXIST
fi


# Validar que el segon argument sigui un directori

if  [  ! -d $2 ]
then
	echo "Error: $mydir no es un directori"
	echo "Usage: $0 dir"
	exit $ERR_NODIR
fi

# XIXA
cp $1 $2
exit 0
