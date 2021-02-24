#! /bin/bash
# @MarcPorto ASIX 2020-2021
# Febrer 2021
# prog file dirdesti
# copiar un ftzer al director destí
# copyfiles file[...] dirdesti
#	Validar arguments
#	Validar dir desti
#	(bucle)per cada file    trobar la llista de tots els files
#	(if)Validar si exiteix file
# 	(else) cp destí
# 
# ------------------------------------
ERR_NARGS=1
ERR_NOEXIST=2
ERR_NODIR=3
# Validem arguments
if [ $# -lt 2 ]
then
	echo "Error: nº arguments incorrecte"
	echo "Usage: $0 dir"
	exit $ERR_NARGS
fi

# llistem els arguments
echo "$#"
echo "$*"
echo $* | sed 's/ [^ ]*$//g'
echo $* | sed 's/^.* //g'
echo $* | cut -d' ' -f1-$(($#-1))
echo $* | cut -d' ' -f$#

# Mostrar l'ultim argument

exit 0
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
