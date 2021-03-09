#! /bin/bash
# asix 18/19
# walid el harrak
# 8) Programa: prog file…
#    a)Validar existeix almenys un file. Per a cada file comprimir-lo. Generar per stdout el nom del file comprimit si s̉ha comprimit correctament, o un missatge d̉error per stderror si no s̉ha pogut comprimir. En
#    En finalitzar es mostra per stdout quants files ha comprimit.
#    Retorna status 0 ok, 1 error nº args, 2 si algun error en comprimir.
#    b) Ampliar amb el cas: prog -h|--help.
#---------------------------------------------------------------------------------------------------------------------------------------------
#validad un arg mínim
ERR_ARG=1
if [ $# -eq 0 ]
then
  echo "Error! Has de posar com a mínim un file"
  echo "Usage: prog file[...]"
  echo $ERR_ARG
fi
#-h p --help
OK=0
if [ $1 = "-h" -o $1 = "--help" ]
then
  echo "asix 18/19, W. El Harrak"
  echo "usage: prog -f|-d arg1 arg2 arg3 arg4"
  exit $OK
fi

#comprimir
cont=0
status=0
for file in $*
do
  if [ -f $file ]
  then
    gzip $file &> /dev/null
    if [ $? -eq 0 ]
    then
      echo "$file s'ha comprimit correctament"
      cont=$((cont+1))
    else
      echo "Error! $file no s'ha pogut comprimir" >> /dev/stderr
      status=2
    fi
  else
    echo "Error! $file no s'ha pogut comprimir" >> /dev/stderr
    status=2
  fi
done
echo "S'han comprimit $cont fitxers"
exit $status


