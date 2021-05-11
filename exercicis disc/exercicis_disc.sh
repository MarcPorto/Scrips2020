#! /bin/bash 
# Roberto Martinez
# 21/04/2020
# Funcions administració de disc
#
# ------------------------------------------------------------------------

# 1) Donat un login calcular amb du l'ocupació del home
# de l'usuari. Cal obtenir el home del fitxer /etc/passwd.

function fsize(){
	login=$1
	ERR_NO_LOGIN=1
	home=$(grep "^$login:" /etc/passwd | cut -d: -f6)
	# Condicio per confirmar que existeix
	if [ -z "$home" ]; then
	    echo "Error: login $login no existeix al sistema" >> /dev/stderr
   	    echo "Usage: fsize login" >> /dev/stderr
    	    return $ERR_NO_LOGIN
	fi
	# programa principal
	du $home 2> /dev/null
	return 0
}


# 2) Aquesta funció rep logins i per a cada login es mostra l'ocupació
# de disc del home de l'usuari usant fsize. Verificar que es rep almenys
# un argument. Per a cada argument verificar si és un login vàlid,
# si no generra una traça d'error.

function loginargs(){
 # Validem arguments (que hi hagi 1 o més login)
 ERR_NARGS=1
  if [ $# -lt 1 ]; then
    echo "Error: num args incorrecte"
    echo "Usage: loginargs login[...]"
    return $ERR_NARGS
  fi
 # Agafem tots a una sola variable i ho fiquem el bucle per iterar cadascun
 llistalogins=$*
 for login in $llistalogins
 do
	 fsize $login
 done
 return 0
}


# 3) Rep com a argument un nom de fitxer que conté un login per línia.
# Mostrar ocupació de disc de cada usuari utilitzant fsize. Verificar
# que es rep un argument i que aquest és un regular file.
function loginfile(){
  OK=0
  ERR_NARGS=1
  ERR_NO_REGFILE=2
  # Validem que hi hagi nomes un argument
  if [ $# -ne 1 ]; then
    echo "Error: num args incorrecte"
    echo "Usage: loginfile regular_file"
    return $ERR_NARGS 
  fi
  # Validem que sigui un regular file
  fileIn=$1
  if [ ! -f "$fileIn" ]; then
    echo "El fitxer $fileIn no és un regular file"
    echo "Usage: loginfile regular_file"
    return $ERR_NO_REGFILE
  fi
  while read -r login
  do
	  fsize $login

  done < $filein
}


# 4) Rep com a argument un file o res (en aquest cas es processa stdin).
# El fitxer o stdin contenen un lògin per línia. Mostrar l'ocupació de
# disc del home de l'usuari. Verificar els arguments rebuts.
# Verificar per a cada login rebut que és vàlid.


function loginboth(){
  fileIn=/dev/stdin
  # Validem que hi hagi un argument
  if [ $# -eq 1 ]; then
    fileIn=$1
  fi
  while read -r login
  do
	  fsize $login
  done < $fileIn
  return 0
}



# 5) Donat un GID com a argument, llistar els logins del usuaris que
# pertànyen al seu grup com a grup principal. Verificar que es rep un
# argument i que és un GID vàlid.

function grepgid(){
  OK=0
  ERR_NARGS=1
  ERR_NOGID=2
  # Validem que hi hagi un argument com a gid
  if [ $# -ne 1 ]; then
    echo "Error: num args incorrecte"
    echo "Usage: grepdid GID"
    return $ERR_NARGS
  fi
  gid=$1
  grep "^[^:]*:[^:]*:$gid:" /etc/passwd &> /dev/null
  if [ $? -ne 0 ]; then
    echo "Error: GID $gid no existeix al sistema"
    echo "Usage: grepgid GID"
    return $ERR_NOGID
  fi
  # busquem el login del gid a /etc/passwd
  grep "^[]*:[]*:[]*:$gid:" /etc/passwd | cut -d: -f1 | sort
  return 0
}


# 6) Donat un GID com a argument, mostra per a cada usuari que pertany
# a aquest gruo l'ocupació del seu home. Verificar que es rep un argument
# i que és un GID vàlid.

function gidsize(){
  OK=0
  ERR_NARGS=1
  ERR_NOGID=2
  # Validem 
  if [ $# -ne 1 ]; then
    echo "Error: num args incorrecte"
    echo "Usage: grepdid GID"
    return $ERR_NARGS
  fi
  gid=$1
  grep "^[^:]*:[^:]*:$gid:" /etc/passwd &> /dev/null
  if [ $? -ne 0 ]; then
    echo "Error: GID $gid no existeix al sistema"
    echo "Usage: grepgid GID"
    return $ERR_NOGID
  fi
  llistaLogins=$(grepgid $gid)
  for login in $llistaLogins
  do
    fsize $login
  done
  return $OK
}

# 7) Llistar de tots els GIDS del sistema (en ordre creixent), l'ocupació
# del home dels usuaris que hi pertànyen.

function allgidsize(){
  OK=0
  llistaGids=$(cut -d: -f4 /etc/passwd | sort -gu)
  for gid in $llistaGids
  do
    echo "$gid"
    gidsize $gid | sed -r 's/^(.*)$/\t\1/'
  done
  return $OK
}

# 8) Llistar totes les línies de /etc/group i per a cada línia llistar
# l'ocupació del home dels usuaris que hi pertànyen. Ampliar filtrant
# només els grups de l'1 al 100.

function allgroupssize(){
  OK=0
  MIN=0
  MAX=100
  fileIn=/etc/group
  while read -r line
  do
    gid=$(echo $line | cut -d: -f3)
    if [ $gid -ge $MIN -a $gid -le $MAX ]; then
      echo "$gid"
      gidsize $gid | sed -r 's/^(.*)$/\t\1/'
    fi
  done < $fileIn
  return $OK
}

# ----------------------------
# FUNCIONS FSTAB
# ----------------------------
# 9) Donat un fstype llista el device i el mountpoint (per odre de device
# de les entrades de fstab d'quest fstype.

function fstype(){
  OK=0
  ERR_NARGS=1
  if [ $# -ne 1  ]; then
    echo "Error: num args incorrecte"
    echo "Usage: nom_function fstype"
    return $ERR_NARGS
  fi
  fstype=$1
  grep -v "^#" /etc/fstab | tr -s '[:blank:]' ' ' | grep "^[^ ]* [^ ]* $fstype" | cut -d' ' -f1,2 | sed -r 's/^(.*)$/\t\1/'
  return $OK
}

# 10) LLista per a cada fstype que existeix al fstab (per ordre
# lexicogràfic) les entrades d'quest tipus.
# Llistar tabuladament el device i el mountpoint.

function allfstype(){
  OK=0
  fstypeList=$(grep -v "^#" /etc/fstab | tr -s '[:blank:]' ' ' | cut -d' ' -f3 | sort -u)
  for fstype in $fstypeList
  do
    echo $fstype
    fstype $fstype
  done
  return $OK
}

# 11) LLista per a cada fstype que existeix al fstab (per ordre
# lexicogràfic) les entrades d'quest tipus. Llistar tabuladament el device
# i el mountpoint. Es rep un valor numèric d'argument que indica el número
# mínim d'entrades d'aquest fstype que hi ha d'haver per sortir al llistat

function allfstypeif(){
  OK=0
  ERR_NARGS=1
    if [ $# -ne 1  ]; then
    echo "Error: num args incorrecte"
    echo "Usage: nom_function fstype"
    return $ERR_NARGS
  fi
  min=$1
  fstypeList=$(grep -v "^#" /etc/fstab | tr -s '[:blank:]' ' ' | cut -d' ' -f3 | sort -u)
  for fstype in $fstypeList
  do
    numEntrades=$(grep -v "^#" /etc/fstab | tr -s '[:blank:]' ' ' | grep "^[^ ]* [^ ]* $fstype" | wc -l)
    if [ $numEntrades -ge $min ]; then
      echo $fstype
      fstype $fstype
    fi
  done
  return $OK
}


