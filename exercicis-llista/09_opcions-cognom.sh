# ! /bin/bash
# edt @Marc Porto
# Programa 6 processa files/dir
# curs 2020-21
# 9) Programa: prog.sh [ -r -m -c cognom  -j  -e edat ]  arg…
#   Escriure el codi que desa en les variables: opcions, cognom, edat i arguments 
#   els valors corresponents.
#   No cal validar ni mostrar res!
#-----------------------------------------
opcions=""
cognom=""
edat=""
args=""

while [ -n "$1" ]
do
	case "$1" in
	"-r"|"-m"|"-j")
		opcions="$opcions $1";;
	"-c")
		cognom=$2
		shift;;
	"-e")
		edat=$2
		shift;;
	*)
		args="$args $1"
	esac
	shift
done
echo "opcions: $opcions"
echo "cognom: $cognom"
echo "edat: $edat"
echo "arguments: $args"
exit 0
