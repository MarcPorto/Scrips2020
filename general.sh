function userid()
{
    uid=$1
    file="/etc/passwd"
    
    usuari=$(grep "^[^:]*:[^:]*:$uid:" $file) 

    login=$(echo $usuari | cut -f1 -d:)
    passwd=$(echo $usuari | cut -f2 -d:)
    uid=$(echo $usuari | cut -f3 -d:)
    gid=$(echo $usuari | cut -f4 -d:)
    gecos=$(echo $usuari | cut -f5 -d:)
    home=$(echo $usuari | cut -f6 -d:)
    shell=$(echo $usuari | cut -f7 -d:)

    echo "login: $login"
    echo "passwd: $passwd"
    echo "uid: $uid"
    echo "gid: $gid"
    echo "gecos: $gecos"
    echo "home: $home"
    echo "shell: $shell"

    return 0
}

# mostrar el contingut del camp gecos
# -----

function gecos() {
    uid=$1
    gecos=$(grep "^[^:]*:[^:]:$uid:" /etc/passwd | cut -d: -f5)

    name=$(echo $gecos | cut -d, -f1)
    office=$(echo $gecos | cut -d, -f2)
    phoffice=$(echo $gecos | cut -d, -f3)
    phhome=$(echo $gecos | cut -d, -f4)
 
    echo "Nom: $name"
    echo "Office: $office"
    echo "Phone Office: $phoffice"
    echo "Phone Home: $phhome"

    return 0
}

# mostrar els usuaris que pertanyen a un gid
#       login uid gid shell
# -----

function usuaris_xgid() {
    gid=$1
    file="/etc/passwd"
 
    while read -r line
    do
    	user=$(echo $line | grep "^[^:]*:[^:]:[^:]*:$gid:")
	    if [ -n "$user" ]
	    then
	        login=$(echo $user | cut -d: -f1)
	        uid=$(echo $user | cut -d: -f3)
	        shell=$(echo $user | cut -d: -f7) 
    	    echo -e "login: $login \nuid:   $uid \ngid:   $gid  \nshell: $shell\n"
        fi
    done < $file 
    return 0
}

function usuaris_xgid2() {
    gid=$1
    file="/etc/passwd"

	grep "^[^:]*:[^:]:[^:]*:$gid:" $file > temp$$
    while read -r line
    do
        login=$(echo $line | cut -d: -f1)
        uid=$(echo $line | cut -d: -f3)
        shell=$(echo $line | cut -d: -f7)
	    echo -e "login: $login \nuid:   $uid \ngid:   $gid  \nshell: $shell\n"
    done < temp$$
    rm temp$$
    return 0
}

function usuaris_xgid3() {
    gid=$1
    file="/etc/passwd"

	grep "^[^:]*:[^:]:[^:]*:$gid:" $file |    while read -r line
    do
        login=$(echo $line | cut -d: -f1)
        uid=$(echo $line | cut -d: -f3)
        shell=$(echo $line | cut -d: -f7)
	    echo -e "login: $login \nuid:   $uid \ngid:   $gid  \nshell: $shell\n"
    done
    return 0
}

## funcio incorrecte! ####
function usuaris_xgid4() {
    gid=$1
    file="/etc/passwd"

	while read -r line
    do
        login=$(echo $line | cut -d: -f1)
        uid=$(echo $line | cut -d: -f3)
        shell=$(echo $line | cut -d: -f7)
	    echo -e "login: $login \nuid:   $uid \ngid:   $gid  \nshell: $shell\n"
    done < $(grep "^[^:]*:[^:]:[^:]*:$gid:" $file)
    return 0
}
##  ##  ##  ##  ##  ##  ##  ##  ## 


function usuaris_xgid5() {
    gid=$1
    file="/etc/passwd"
 
    for uid in $(grep "^[^:]*:[^:]:[^:]*:$gid:" $file | cut -d: -f 3)
    do
    	user=$(grep "^[^:]*:[^:]:$uid:" $file)
		if [ -n "$user" ]
		then
			login=$(echo $user | cut -d: -f1)
			shell=$(echo $user | cut -d: -f7)
			echo -e "login: $login \nuid:   $uid \ngid:   $gid  \nshell: $shell\n"
        fi
    done < $file 
    return 0
}

function gsecundaris_xuid() {
    fileUsers="/etc/passwd"
    fileGroups="/etc/group"
    uid=$1    
  
    login=$(grep "^[^:]*:[^:]*:$uid:" $fileUsers | cut -d: -f1)
    #grups=$(grep "^[^:]*:[^:]*:[^:]*:.*$login" $fileGroups | cut -d: -f1,3) \
	#	   | sed -r "s/([^:]*):([^:])/$ngrp Grup\(\2\): \1/"
	
	ngrp=1
	for grupTupla in $(grep "^[^:]*:[^:]*:[^:]*:.*$login" $fileGroups | cut -d: -f1,3)
	do
		echo $grupTupla | sed -r "s/([^:]*):([^:])/$ngrp Grup\(\2\): \1/"
		ngrp=$(($ngrp+1))
	done
    return 0
}

# Donat un gid dir quins són tots els usuaris que hi pertanyen com a 
# secundaris:
#	a) s'accepta repetir el grup primari.
#	b) no s'accepta
# ----------------------------------------------------------------------


function usecundaris_xgid() {
    fileUsers="/etc/passwd"
    fileGroups="/etc/group"
    gid=$1    
  
    grup=$(grep "^[^:]*:[^:]*:$gid:" $fileGroups)
    gname=$(echo $grup | cut -d: -f1)
    users=$(echo $grup | cut -d: -f4)
    
    nusers=$(echo $users | tr ',' ' ' | wc -w) 
    echo "$gname($gid)= $users (total $nusers)"

    return 0
}

function usecundaris_xgid2() {
    fileUsers="/etc/passwd"
    fileGroups="/etc/group"
    gid=$1    
  
    grup=$(grep "^[^:]*:[^:]*:$gid:" $fileGroups)
    gname=$(echo $grup | cut -d: -f1)
    users=$(echo $grup | cut -d: -f4)
	
	echo "Usuaris del grup $gname($gid):"
    for login in $(echo $users | tr ',' ' ' ) 
    do
		linia=$(grep "^$login:" $fileUsers)
		uid=$(echo $linia | cut -d: -f3)
		shell=$(echo $linia | cut -d: -f7)
		echo -e "\t$login($uid) \t$shell"
	done
    return 0
}


# Mostrar els camps delfitxer shadow donat un uid
# ----------------------------------------------------------------------


function shadow_xuid() {
    fileShadow="/etc/shadow"
    fileUsers="/etc/passwd"
    uid=$1
	
    login=$(grep "^[^:]*:[^:]*:$uid:" $fileUsers | cut -d: -f1)
    linia=$(grep "^$login:" $fileShadow)
   
    passwd=$(echo $linia | cut -d: -f2)
	date=$(echo $linia | cut -d: -f3)
	minAge=$(echo $linia | cut -d: -f4)
	maxAge=$(echo $linia | cut -d: -f5)
	warning=$(echo $linia | cut -d: -f6)
	inactivity=$(echo $linia | cut -d: -f7)
	expiration=$(echo $linia | cut -d: -f8)
	reserved=$(echo $linia | cut -d: -f9)

    echo "login: $login"
	echo "passwd: $passwd"
	echo "date: $date"
	echo "minAge: $minAge"
	echo "maxAge: $maxAge"
	echo "warning: $warning"
	echo "inactivity: $inactivity"
	echo "expiration: $expiration"
	echo "reserved: $reserved"

    return 0
}

# donat el nom d'una classe/grup com per exemple hisx,
# crear deu usuaris d'aquest grup amb els requeriments:
#   - grup pròpi per a tots els usuaris de idem nom (primari)
#   - home a /home_tmp/<grup>
#   - utilitzar un esquelet de home pròpi
#   - usuaris de nom hisx01..hisix10
# ----------------------------------------------------------------------
ERR_grup=1
ERR_home=2
dir_skel="/etc/skel_hisx"
pass_fake="alumne"

function crear_classe() {
    classe=$1
	
    # creació de l'esquelet (fet prèviament)
    # mkdir -p /etc/skel_hisx
    # cp -ra /etc/skel/. /etc/skel_hisx

    # Crear el grup pròpi
    groupadd $classe || \
        (echo "Error: no s'ha pogut crear el grup $classe" > /dev/stderr; return $ERR_grup)

    # Crear el basedir per als home dels usuaris
    mkdir -p /home_tmp/$classe || \
        (echo "Error: no s'ha pogut crear el home per a la classe" > /dev/stderr; return $ERR_home)

    # Crear els usuaris i activar els comptes
    for user in hisx{0{1..9},{10}}
    do
        useradd -n -g $classe -m -k $dir_skel -b /home_tmp/$classe $user \
            echo "Error en crear l'usuari: $user" > /dev/stderr    
        #echo $pass_fake | passwd $pass_fake --stdin
        passwd $pass_fake --stdin <<$pass_fake
    done

    return 0
}


