# ! /bin/bash
# edt @Marc Porto
# Programa 6 processa files/dir
# curs 2020-21
# 10) Programa: prog.sh 
#    Rep per stdin GIDs i llista per stdout la informació de cada un d’aquests grup# s , en format: gname: GNAME, gid: GID, users: USERS
#-----------------------------------------
OK=0
if [ $# -eq 1 -a "$1" = "-h" ]
then
	echo "mostrant el help"
	exit 0
fi
if [ $# -eq 0 ]
then
	echo "err num args"
	echo "usage"
	exit 1
fi
for uid in $*
do
	linia=$(grep "^[^:]*:[^:]*:$uid:" /etc/passwd)
	if [ $? -eq 0 ];
	then
	login=$(echo $linia | cut -d: -f1)
	gid=$(echo $linia | cut -d: -f4)
	gname=$(grep "^[^:]*:[^:]*:$gid:" /etc/group | cut -d: -f1)
	dirhome=$(echo $linia | cut -d: -f 6)
	shell=$(echo $linia | cut -d: -f7)
	echo "$login($uid) $gname $dirhome $shell"
	else
		echo "ERROR: $uid inexistent" >> /dev/stderr
		
	fi	
done
exit $OK
