#! /bin/bash
# @MarcPorto ASIX 2020-2021
# Febrer 2021
# 
# [ -a file -b -c -d num -e ] arg[...]
# ------------------------------------------
file=''
opcions=''
args=''
num=''
while [ -n "$1" ]
do	
	case $1 in
		-[bce])
			opcions="$opcions $1";;
		-a)
			file=$2
			shift;;
		-d)
			min=$2
			max=$3
			shift
			shift;;
		*)
			args="$args $1";;
	esac
	shift
	
done
echo "opcions: $opcions"
echo "arguments: $args"
echo "file: $file"
echo "min: $min"
echo "max: $max"
exit 0
