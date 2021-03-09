#! /bin/bash
# @edt ASIX M01-ISo Curs 2019-2020
#
# Scripts bàsics
#    dies de la setmana si són laborable o festiu
#    prog dia[...]
# -------------------------------------------------------------------
laborable=0
festiu=0
for dia in $*
do
  case $dia in
  d[ltcjv]) 
    laborables=$((laborables+1));;
  ds|dm) 
    festius=$((festius+1));;
  *) 
    echo "dia: $dia erroni" >> /dev/stderr;; 
  esac
done
echo "laborables: $laborables"
echo "festius: $festius"
