#!/bin/bash

clear
echo -e "Preparing..."
sudo apt-get update > /dev/null 2>&1
sudo apt-get install lolcat -y > /dev/null 2>&1
cp /usr/games/lolcat /usr/bin/
clear
echo "Welcome in System Installer" | lolcat -a -d 100
echo -e " "
echo -e "[ INFO ] install Script Installer" | lolcat
wget -q -O /usr/bin/ins "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/ins.sh" && chmod +x /usr/bin/ins
wget -q -O /home/ver "https://raw.githubusercontent.com/rizz-code/netvpn/main/version"
echo -e "[ INFO ] Please Wait..." | lolcat
sleep 2
echo -e "[ OK ] Done" | lolcat
sleep 3
clear
echo -e " "
echo -e "[ INFO ] Installing Module Needed" | lolcat
echo -e "[ INFO ] Please Wait..." | lolcat
apt update -y > /dev/null 2>&1
echo -e "[ OK ] Done 1 / 5 " | lolcat
echo -e "[ INFO ] Jika lebih dari 2 menit tekan 'ENTER' " | lolcat
apt dist-upgrade -y > /dev/null 2>&1
echo -e "[ OK ] Done 2 / 5 " | lolcat
apt upgrade -y > /dev/null 2>&1
echo -e "[ OK ] Done 3 / 5 " | lolcat
sudo apt-get install wget -y > /dev/null 2>&1
echo -e "[ OK ] Done 4 / 5 " | lolcat
sudo apt-get install screen -y > /dev/null 2>&1
echo -e "[ OK ] Done 5 / 5 " | lolcat
sleep 2
echo -e "[ OK ] Done ALL" | lolcat


cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
ins
END
chmod 644 /root/.profile

clear
echo -e "[ INFO ] Step 1 berasil di install" | lolcat
echo -e "[ INFO ] Silahkan reboot dan lanjut ke step berikutnya" | lolcat
echo -e " "
echo -ne "[ WARNING ] Reboot Sekarang ? (y/n)? " | lolcat
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
rm -rf setup.sh
exit 0
else
rm -rf setup.sh
reboot
fi
