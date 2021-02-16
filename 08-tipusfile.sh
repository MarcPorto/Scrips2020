#! /bin/bash
# @MarcPorto
# Febrer 2021
# llistar el directori si existeix
#  $ prog file
# --------------------------------------------
# si el num d'arguments no es 1
ERR_NARGS=1
ERR_NOEXIST=2
if [$# -ne 1 ]
then
          echo "Error: nº arguments incorrecte"
	  echo "Usage: $0 dir"
	  exit $ERR_NARGS
fi

exit 0



# xixa
fit=$1
if  [ ! -e $fit ]; then
	echo "ERROR: $fit no existeix"
	exit $ERR_NOEXIST
elif [  -h $fit ]; then
	echo "$fit symbolic link"

elif [  -f $fit ]; then
	echo "$fit symbolic file"

elif [  -d $fit ]; then
	echo "$fit symbolic directori"

else

