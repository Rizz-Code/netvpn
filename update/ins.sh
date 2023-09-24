#!/bin/bash

clear
clear
echo "Welcome in System Installer" | lolcat -a -d 100
echo -ne "[ WARNING ] Lanjutkan installasi sekarang ? (y/n)? " | lolcat
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
echo -e "[ INFO ] Jika ingin melanjutkan pengistalan silahkan ketik 'ins' " | lolcat
echo -e "[ INFO ] Tanpa tanda petik ('') " | lolcat
exit 0
else
cat >/var/lib/ch.txt<< EOF
CHATID=-1001785786113
CHATIDGC=-1001855655763
KEY="6593098466:AAEBR5isu9SLa131ia20rNZs-VbSaPJ5mGc"
EOF

wget -q https://raw.githubusercontent.com/rizz-code/netvpn/main/install.sh && chmod +x install.sh && ./install.sh
fi
