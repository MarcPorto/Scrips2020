#! /bin/bash
# @edt ASIX M01-ISo Curs 2019-2020
#
# Scripts bàsics
#  mostrar l'entrada rnomés 50 primer caràcters
# -------------------------------------------------------------------
while read -r line
do	
  echo $line | cut -c1-50
done


