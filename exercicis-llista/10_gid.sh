# ! /bin/bash
# edt @Marc Porto
# Programa 6 processa files/dir
# curs 2020-21
# 10) Programa: prog.sh 
#    Rep per stdin GIDs i llista per stdout la informació de cada un d’aquests grup# s , en format: gname: GNAME, gid: GID, users: USERS
#-----------------------------------------
OK=0
while read -r gid
do
	groupLine=$(grep "^[^:]*:[^:]*:$gid:" /etc/group)
	if [ $? -eq 0 ];
	then
	gname=$(echo $groupLine | cut -d: -f1 | tr '[a-z]' '[A-Z]')
	users=$(echo $groupLine | cut -d: -f4 | tr '[a-z]' '[A-Z]')
	echo "gname: $gname, gid: $gid, users: $users"
	else
		echo "ERROR: $gid inexistent" >> /dev/stderr
		OK=1
	fi	
done
exit $OK
