# ! /bin/bash
# edt @Marc Porto
# Programa 6 processa stdin
# curs 2020-21
# 7) Programa: prog -f|-d arg1 arg2 arg3 arg4
# a) Valida que els quatre arguments rebuts són tots del tipus que indica el flag.
# És a dir, si es crida amb -f valida que tots quatre són file.
# Si es crida amb -d valida que tots quatre són directoris.
#    Retorna 0 ok, 1 error nº args, 2 hi ha elements errònis. 
#    Exemple: prog -f carta.txt a.txt /tmp fi.txt → retorna status 2. 
#  b) Ampliar amb el cas: prog -h|--help.
#-----------------------------------------
OK=0
ERR_NARGS=1
ERR_ELEM=2

if [ "$#" -ne 5 ]
then
	echo "ERROR: numero d'arguments no vàlid"
	echo "Usage: 07.sh -f|-d arg1 arg2 arg3 arg4"
	exit $ERR_NARGS
fi

if [ "$1" != "-f" -a $1 != "-d" ]
then
	echo "ERROR: format d'arguments no vàlid"
	echo "Usage: 07.sh -f|-d arg1 arg2 arg3 arg4"
	exit $ERR_ELEM
fi
tipus=$1
shift
for arg in $*
do
	if ! [ $tipus "$arg" ]; then
		OK=2
	fi
done
exit $OK
