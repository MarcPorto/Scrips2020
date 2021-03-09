#! /bin/bash
# MarcPorto ASIX M01-ISO
# Febrer 2021
# Exemple if
#   $ prog edat
# ------------------------------
if [ $# -ne 1 ];
	echo "Error: nºarguments incorrecte"
	echo "Usage: $0 edat"
	exit 1
fi

echo $1
