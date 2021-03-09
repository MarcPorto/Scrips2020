#! /bin/bash
# @MarcPorto
# Febrer 2021
# primer exemple script
# ---------------------------
echo "Hello World"
echo "Bon dia, avui plou"
nom="Marc Porto"
edat=18
echo $nom $edat
echo -e "nom: $nom\n edat: $edat"

echo -e 'nom: $nom\n edat: $edat'
uname -a
uptime
echo $SHELL
echo $SHLVL
echo $((4*32))
echo $((edat*2))
read data1 data2
echo -e "$data1\n $data2"
exit 0


