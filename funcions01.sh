#! /bin/bash
# Exemples de funcions
# validar rep 1 arg
# validar existeix usuari
# mostrar camp a camp
# login: $login
# uid: $uid

function showuser(){
	# Validem rep 1 arg
	if [ $# -lt 1 ]
	then
		echo "Error: nº arg no vàlid"
		echo "Usage: prog.sh..."
		return 1
	elif [ $# -gt 1 ]
	then
		echo "Error: nº arg no vàlid"
		echo "Uosage: prog.sh ..."
		return 1
	fi

	#mostrem camp a camp
	id $1
	return 0
}


function dia(){
	date
	return 0
}
function suma(){
	echo "La suma és: $(($1+$2))"
	return 0
}
