# ! /bin/bash
# edt @Marc Porto
# Programa 6 processa stdin
# curs 2020-21
# 6) Processar per stdin linies d’entrada tipus “Tom Snyder” i mostrar per stdout l#  a línia en format → T. Snyder.
#-----------------------------------------
OK=0
while read -r line
do
	nom=$(echo $line | cut -c1)
	cognom=$(echo $line | cut -d' ' -f2)
	echo "$nom. $cognom"

done
exit $OK
