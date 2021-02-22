#! /bin/bash
# @MarcPorto ASIX 2020-2021
# Febrer 2021
# llistar el directori si existeix
#  $ prog més
# ----------------------------------
num=1
# 9) mostrar entrada estandar numerada i en majuscules
while read -r line
do
                echo "$num: $line" | tr '[a-z]' '[A-Z]'
                ((num++))
done
exit 0


# 8) mostrar stdin fins a token FI
read -r line
while [ "$line" != "FI" ]
do
	echo "$line"
	read -r line
done
exit 0


num=1
# exmeple estandard: mostrar l'entrada linia a linia  comptada
while read -r line
do
		echo "$num: $line"
		num=$(($num+1))
done 
exit 0


# exmeple estandard: mostrar l'entrada linia a linia
while read -r line
do
                echo $line
done
exit 0
				


# mostrar arguments
num=1
while [ "$1" ]
do
	        echo "$num: $1, $#, $*"
	        num=$((num+1))
	        shift
done
exit 0



# mostrar arguments V2
num=1
while [ $# -gt 0  ]
do
	echo "$num: $1, $#, $*"
	num=$((num+1))
	shift
done
exit 0



# mostrar arguments
while [ -n "$1" ]
do
	echo "$1 $#: $*"
	shift
done
exit 0



# comptador recreixent del arg rebut [n-0]
MIN=0
num=$1
while [ $num -ge $MIN  ]
do
	echo -n "$num,  "
	((num--))
done
exit 0
