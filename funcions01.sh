#! /bin/bash
# Exemples de funcions
# validar rep 1 arg
# validar existeix usuari
# mostrar camp a camp
# login: $login
# uid: $uid


function creaescola(){
	for classe in metall fusta quimica
	do
		creaclasse $classe
	done

}

function creaclasse(){
	classe=$1
	PASSWD="alum"
	llista_noms=$(echo ${classe}{00..03})
	for user in $llista_noms
	do
		 useradd $user
		 echo "$user:$PASSWD" | chpasswd
		 #chpasswd < file
		#echo "alum" | passwd --stdin $user &> /dev/null
	done



}


function showAllGroups(){
	MIN_USERS=2
	llista_gids=$(cut -d: -f4 /etc/passwd | sort -n | uniq)
	for gid in $llista_gids
	do
		count=$(grep "^[^:]*:[^:]*:$gid:" /etc/passwd | wc -l)
		if [ $count -ge $MIN_USERS ]
		then
			gname=$(grep "^[^:]*:[^:]*:$gid:" /etc/group | cut -d: -f1)
			echo "$gname($gid): $count"
			grep "^[^:]*:[^:]*:[^:]*:$gid:" /etc/passwd | cut -d: -f1,3,7 | sed -r 's/^(.*)$/\t\1/'
		fi
	done
	return 0

}



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
