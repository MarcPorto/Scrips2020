#! /bin/bash
# @edt 2012
# funcions d'usuari
#
# ######################################################################

# ----------------------------------------------------------------------
# mostrar info de l'usuari 
# ----------------------------------------------------------------------

# Donat un UID mostra info del account
function mostraAccount(){
  file="passwd.txt"
  uid=$1
  user=$( cat $file | grep "^[^:]*:[^:]*:$uid:"  ) 

  login=$( echo $user | cut -f1 -d: )
  gid=$(   echo $user | cut -f4 -d: )
  home=$(  echo $user | cut -f6 -d: )
  shell=$( echo $user | cut -f7 -d: )

  echo "login: $login"
  echo "uid: $uid"
  echo "gid: $gid"
  echo "home: $home"
  echo "shell: $shell"
  return 0
}

# Donat un UID mostrar el GECOS
function mostraGecos(){
  file="passwd.txt"
  uid=$1
  user=$( cat $file | grep "^[^:]*:[^:]*:$uid:"  )
  gecos=$( echo $user | cut -f5 -d: )
  
  name=$(  echo $gecos | cut -f1 -d, )
  office=$( echo $gecos | cut -f2 -d, ) 
  office_phone=$(  echo $gecos | cut -f3 -d, )
  home_phone=$( echo $gecos | cut -f4 -d, )

  echo "full_name: $name"
  echo "office: $office"
  echo "office_phone: $office_phone"
  echo "home_phone: $home_phone"
  return 0
}

# Donat un UID mostrar la política de passwd
function mostraPasswd(){
  file_passwd="passwd.txt"
  file="shadow.txt"
  uid=$1

  user=$( cat $file_passwd | grep "^[^:]*:[^:]*:$uid:"  )
  login=$( echo $user | cut -f1 -d: )
  user_passwd=$( cat $file | grep "^$login:"  )

  passwd=$(echo $user_passwd | cut -d: -f2)
  date=$(echo $user_passwd | cut -d: -f3)
  minAge=$(echo $user_passwd | cut -d: -f4)
  maxAge=$(echo $user_passwd | cut -d: -f5)
  warning=$(echo $user_passwd | cut -d: -f6)
  inactivity=$(echo $user_passwd | cut -d: -f7)
  expiration=$(echo $user_passwd  | cut -d: -f8)
  reserved=$(echo $user_passwd | cut -d: -f9)

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

function mostraUsuari(){
  if [ $# -ne 1 ]
  then
    echo "Error! nº arguments invalid"
    echo "usage: mostraUsuari uid"
    return 1
  fi
  
  uid=$1
  echo -e "Usuari: $uid\n"
  mostraAccount $uid
  echo -e "\nGecos:"
  mostraGecos $uid
  echo -e "\nPasswd:"
  mostraPasswd $uid
  return 0
}


# ----------------------------------------------------------------------
# mostrar info del grup
# ----------------------------------------------------------------------

# Donat un GID mostrar les dades del grup (/etc/group)
function mostraGrup(){
  file="group.txt"
  gid=$1
  grup=$( cat $file | grep "^[^:]*:[^:]*:$gid:"  )
  if [ -z "$grup" ]
  then
    echo "Grup ($gid) inexistent!"
    return 1
  fi

  gname=$( echo $grup | cut -f1 -d: )
  users=$( echo $grup | cut -f4 -d: )

  echo "gname $gname"
  echo "gid: $gid"
  echo "users: $users"
  return 0
}

# Donat un GID mostrar les dades del /etc/gshadow 
function mostraGPasswd(){
  file="gshadow.txt"
  file_group="group.txt"
  gid=$1
  gname=$( cat $file_group | grep "^[^:]*:[^:]*:$gid:" | cut -f1 -d: )
  if [ -z "$gname" ]
  then
    echo "Grup ($gid) inexistent!"
    return 1
  fi
  grup=$( cat $file | grep "^$gname:"  )

  admins=$( echo $grup | cut -f3 -d: )
  members=$( echo $grup | cut -f4 -d: )

  echo "gname $gname"
  echo "gid: $gid"
  echo "admins: $admins"
  echo "members: $members"
  return 0
}


# ======================================================================
# Combinar fitxers d'usuaris i grups
# ======================================================================

# Donat un gname mostrar gname(gid) i la llista d'usuaris que hi 
# pertanyen com a  grup principal
function usuarisPrincipal(){
  if [ $# -ne 1 ]
  then
    exit 1
  fi
  # 1) obtenir el gname (groups)
  gname=$1
  file_passwd="passwd.txt"
  file_group="group.txt"
  gid=$(grep "^$gname:" $file_group | cut -f3 -d:)
  # 2) si no hi ha el grup plegar
  if [ -z "$gid" ]
  then
    return 2
  fi
  # 3) filtrar passwd.txt per gid (4rt camp)  
  grep "^[^:]*:[^:]*:[^:]*:$gid:" $file_passwd | cut -f1 -d:
  return 0
}

# Versió 2:
# usuarisPrincipal2()
# motrar per a cada usuari "login(uid)"
function usuarisPrincipal2(){
  if [ $# -ne 1 ]
  then
    exit 1
  fi
  # 1) obtenir el gname (groups)
  gname=$1
  file_passwd="passwd.txt"
  file_group="group.txt"
  gid=$(grep "^$gname:" $file_group | cut -f3 -d:)
  # 2) si no hi ha el grup plegar
  if [ -z "$gid" ]
  then
    return 2
  fi
  # 3) filtrar passwd.txt per gid (4rt camp)  
  grep "^[^:]*:[^:]*:[^:]*:$gid:" $file_passwd \
  | cut -f1,3 -d: \
  | sed -r 's/^([^:]*):(.*)$/\1(\2)/'
  return 0
}

# Versió 3:
# usuarisPrincipal3()
# mostrar per a cada usuari "login uid home"
function usuarisPrincipal3(){
  if [ $# -ne 1 ]
  then
    exit 1
  fi
  # 1) obtenir el gname (groups)
  gname=$1
  file_passwd="passwd.txt"
  file_group="group.txt"
  gid=$(grep "^$gname:" $file_group | cut -f3 -d:)
  # 2) si no hi ha el grup plegar
  if [ -z "$gid" ]
  then
    return 2
  fi
  # 3) filtrar passwd.txt per gid (4rt camp)  
  grep "^[^:]*:[^:]*:[^:]*:$gid:" $file_passwd \
  | cut -f1,3,6 -d: | tr ':' '\t'
  return 0
}

# Versió 4:
# usuarisPrincipal4()
# mostrar per a cada usuari "login uid home" només si el seu shell 
# és el bash.
# nota: cal usar un for per iterar cada login que pertany al gid.
function usuarisPrincipal4(){
  if [ $# -ne 1 ]
  then
    exit 1
  fi
  # 1) obtenir el gname (groups)
  gname=$1
  file_passwd="passwd.txt"
  file_group="group.txt"
  gid=$(grep "^$gname:" $file_group | cut -f3 -d:)
  # 2) si no hi ha el grup plegar
  if [ -z "$gid" ]
  then
    return 2
  fi
  # 3) filtrar passwd.txt per gid (4rt camp)  
  grep "^[^:]*:[^:]*:[^:]*:$gid:" $file_passwd \
  | grep ":/bin/bash$" \
  | cut -f1,3,6 -d:
  return 0
}

# Versió 5:
# usuarisPrincipal5()
# mostrar per a cada usuari "login: login, uid: uid
# home: home" només si el seu shell és el bash.
function usuarisPrincipal5(){
  if [ $# -ne 1 ]
  then
    exit 1
  fi
  # 1) obtenir el gname (groups)
  gname=$1
  file_passwd="passwd.txt"
  file_group="group.txt"
  gid=$(grep "^$gname:" $file_group | cut -f3 -d:)
  # 2) si no hi ha el grup plegar
  if [ -z "$gid" ]
  then
    return 2
  fi
  # 3) filtrar passwd.txt per gid (4rt camp)  
  logins=$(grep "^[^:]*:[^:]*:[^:]*:$gid:" $file_passwd \
  | grep ":/bin/bash$" \
  | cut -f1 -d:)
echo $logins
  cont=1
  for login in  $logins
  do
    echo "$cont: $login"
    linia_user=$(grep "^$login:" passwd.txt)
    uid=$(echo $linia_user | cut -f3 -d:)  
    home=$(echo $linia_user | cut -f6 -d:)  
    echo -e "\taccount: $login"
    echo -e "\tuid: $uid"
    echo -e "\thome: $home\n"
    cont=$(($cont+1))
  done
  return 0
}


# Donat gname mostrar gname(gid) i la llista dels usuaris que hi 
# pertanyen com agrup secundari.
function usuarisSecundari(){

  return 0
}

# Donat gname mostrar gname(gid) i la llista dels usuaris que hi 
# pertanyen tant com a principal com a secundari.
function usuarisGrup(){
  return 0
}

# ----------------------------------------------------------------------
# 5) Comptar quants usuaris té un grup.
# ----------------------------------------------------------------------

# Funcio quantsPrincipal
#       Donat un nom de grup,  mostrar cada un dels usuaris que tenen 
#       aquest grup com a grup principal.

# Funcio quantsSecundari
#       Donat un nom de grup,  mostrar cada un dels usuaris que tenen 
#       aquest grup com a grup secundari.

# Funcio quantsGroup
#       Donat un nom de grup,  mostrar quants usuaris que tenen aquest
#       grup com a grup principal i com a secundari:
