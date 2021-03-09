# ! /bin/bash
# edt @Marc Porto
# Programa 6 processa files/dir
# curs 2020-21
# 8) Programa: prog file…
#   a)Validar existeix almenys un file. Per a cada file comprimir-lo. 
# Generar per stdout el nom del file comprimit si s’ha comprimit correctament, o un# missatge d’error per stderror si no s’ha pogut comprimir. En finalitzar es mostra# per stdout quants files ha comprimit. 
#     Retorna status 0 ok, 1 error nº args, 2 si algun error en comprimir.
#-----------------------------------------
OK=0
ERR_NARGS=1
ERR_COMP=2
if [ $# -lt 1 ]
then
	echo "ERROR: numero d'arguments no vàlid"
	echo "Usage: prog file…"
	exit $ERR_NARGS
fi
num=0
for file in $*
do
	echo "comprimint"
	if [ $? -eq  0 ];
	then
		echo $file
		num=$((num+1))
	else
		echo "ha anat malament $file" >> /dev/stderr
		OK=2
	fi
done
exit $OK
