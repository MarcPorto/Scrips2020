# ! /bin/bash
# edt @Marc Porto
# Programa 5 processa stdin
# curs 2020-21
# 5) Processar stdin mostrant per stdout les línies de menys de 50 caràcters.
#-----------------------------------------
OK=0
while read -r line
do
	chars=$(echo $line | wc -c)
	if [ $chars -lt 50 ]
	then
		echo $line
	fi

done
exit $OK
