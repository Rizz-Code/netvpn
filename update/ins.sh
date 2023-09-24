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
wget -q https://raw.githubusercontent.com/rizz-code/netvpn/main/install.sh && chmod +x install.sh && ./install.sh
fi