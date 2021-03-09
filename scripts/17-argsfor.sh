#! /bin/bash
# @MarcPorto ASIX 2020-2021
# Febrer 2021
# 
# [ -a -b -c -d    -f -g ] arg[...]
# -----opcions----------   -arguments-
# opcions: ...
# arguments: ...
# prog -b -c arg 1 -d arg2 arg 3
# opcions: -b -c -d
# arguments: arg1 arg2 arg3
# --------------------------------------------------
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
opcions=""
arguments=""
for arg in $*
do
	case $arg in
		"-a"|"-b"|"-c"|"-d"|"-f"|"-g")
			opcions="$opcions $arg";;
		*)
			arguments="$arguments $arg";;
	esac
done
echo "Opcions: $opcions"
echo "Arguments: $arguments"
