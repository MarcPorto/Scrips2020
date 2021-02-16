#! /bin/bash
# @MarcPorto ASIX 2020-2021
# Febrer 2021
# llistar el directori si existeix
#  $ Exemples case
# ----------------------------
# dl dt dx dj dv ds dm
case $1 in
	"dl"|"dt"|"dx"|"dj"|"dv")
		echo "és laborable";;
	"ds"|"dm")
		echo "és cap de setmana";;

esac
exit 0


# 2) Dir si és vocal, consonant o altre
case $1 in
	[aeiou])
		echo "és una vocal";;
	[bcdfghjklmnpqrstvwxyz])
		echo "és una consonant";;
	*)
		echo "és una altra cosa";;

esac
exit 0


# 1) exemple noms
case $1 in
  "pere"|"pau"|"joan")
	  echo "és un nen";;
  "marta"|"anna"|"julia")
	  echo "és una nena"
	  ;;
  *)
	  echo "indefinit";;
esac
exit 0


