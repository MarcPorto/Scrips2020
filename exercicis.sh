
function fsize(){
 login=$1
 home=''
 home=$(grep "^$login:" /etc/passwd | cut -d: -f6)
 du -sh $home
 return 0
}

# ex. 2
function loginargs(){
 llistalogin=$*
 for login in $llistalogin
 do
  fsize $login
 done
 return 0
}

# ex 3
function loginfile(){
 while read -r login
 do
  fsize $login
 done < $1
 return 0
}
# ex 4
function loginboth(){
 while read -r login
 do
  fsize $login
 done
                                                                 1,0-1         Top
# ex 9
function fstype(){
 fstype=$1
 grep -v "^#" /etc/fstab | tr -s '[:blank:]' ' ' | grep "^[^ ]* [^ ]* $fstype" | cut -d' ' -f1,2 | sed -r 's/^(.*)$/\t\1/'
 return 0
}
# ex 10
function allfstype(){
 fstypelist=$(grep -v"^#" /etc/fstab | tr -s '[:blank:]' ' ' | cut -d' ' -f3 | sort -u)
 for fstype in $fstypelist
 do
	 echo $fstype
	 fstype $fstype
 done 
 return 0
}


