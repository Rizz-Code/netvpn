#!/bin/bash
# =========================================
BOT="https://raw.githubusercontent.com/Rizz-Code/extra/main/"
UPDATE="https://raw.githubusercontent.com/rizz-code/netvpn/main/update/update.sh"
GREEN='\033[0;32m'
RED='\033[0;31m'
colornow=$(cat /etc/ssnvpn/theme/color.conf)
COLOR1="$(cat /etc/ssnvpn/theme/$colornow | grep -w "TEXT" | cut -d: -f2|sed 's/ //g')"
COLBG1="$(cat /etc/ssnvpn/theme/$colornow | grep -w "BG" | cut -d: -f2|sed 's/ //g')"
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
NC='\e[0m'
version=$(cat /home/ver)
last_update=$(grep -oP 'Last update:\s*\K[^\n]*' /home/ver)
bold=$(tput bold)
normal=$(tput sgr0)

DATE=$(date +'%d %B %Y')
datediff() {
    d1=$(date -d "$1" +%s)
    d2=$(date -d "$2" +%s)
    Expiry=$(( (d1 - d2) / 86400 ))  
}
mai="datediff "$Exp" "$DATE""
ipsaya=$(wget -qO- ipinfo.io/ip)
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://accessvpn.onrender.com"
checking_sc() {
  useexp=$(wget -qO- $data_ip | grep $ipsaya | awk '{print $3}')
  if [[ $date_list < $useexp ]]; then
    echo -ne
  else
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e "\033[42m          404 NOT FOUND AUTOSCRIPT          \033[0m"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    echo -e ""
    echo -e "            ${RED}PERMISSION DENIED !${NC}"
    echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
    echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
    echo -e "             \033[0;33mContact Admin :${NC}"
    echo -e "      \033[0;36mTelegram${NC} t.me/Akusiapaoiii"
    echo -e "      ${GREEN}WhatsApp${NC} wa.me/085786569083"
    echo -e "\033[1;93m────────────────────────────────────────────\033[0m"
    exit
  fi
}
checking_sc
clear

ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
MYIP=$(curl -sS ipv4.icanhazip.com)
Name=$(curl -sS https://accessvpn.onrender.com | grep $MYIP | awk '{print $2}')
reseller=$(curl -sS https://accessvpn.onrender.com | grep $MYIP | awk '{print $6}')
if [ "$res" = "Expired" ]; then
Exp="\e[36mExpired\033[0m"
else
Exp=$(curl -sS https://accessvpn.onrender.com | grep $MYIP | awk '{print $3}')
fi

# =========================================
vlx=$(grep -c -E "^#& " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^### " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"

trx=$(grep -c -E "^#! " "/etc/xray/config.json")
let tra=$trx/2
ssx=$(grep -c -E "^## " "/etc/xray/config.json")
let ssa=$ssx/2

UDPX="https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2"
# // Exporting Language to UTF-8
export LC_ALL='en_US.UTF-8'
export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.utf8'

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
reseller=$(curl -sS https://accessvpn.onrender.com | grep $MYIP | awk '{print $6}')
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
tram=$( free -h | awk 'NR==2 {print $2}' )
uram=$( free -h | awk 'NR==2 {print $3}' )
uphours=`uptime -p | awk '{print $2,$3}' | cut -d , -f1`
upminutes=`uptime -p | awk '{print $4,$5}' | cut -d , -f1`
uptimecek=`uptime -p | awk '{print $6,$7}' | cut -d , -f1`
cekup=`uptime -p | grep -ow "day"`
jumssh="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
jumlahxray=$(grep -c -E "^### " "/etc/xray/config.json")
let jumx=$jumlahxray/2

# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'

# // Export Banner Status Information
export EROR="[${RED} EROR ${NC}]"
export INFO="[${YELLOW} INFO ${NC}]"
export OKEY="[${GREEN} OKEY ${NC}]"
export PENDING="[${YELLOW} PENDING ${NC}]"
export SEND="[${YELLOW} SEND ${NC}]"
export RECEIVE="[${YELLOW} RECEIVE ${NC}]"

# // Export Align
export BOLD="\e[1m"
export WARNING="${RED}\e[5m"
export UNDERLINE="\e[4m"

# // Exporting URL Host
export Server_URL="autosc.me/aio"
export Server_Port="443"
export Server_IP="underfined"
export Script_Mode="Stable"
export Auther="FranataSTORE"

data_ip="https://kytvpn.xcodehoster.com/izin"
d2=$(date -d "$date_list" +"+%s")
d1=$(date -d "$Exp" +"+%s")
dayleft=$(( ($d1 - $d2) / 86400 ))

# // Root Checking
if [ "${EUID}" -ne 0 ]; then
                echo -e "${EROR} Please Run This Script As Root User !"
                exit 1
fi


# // Exporting IP Address
export IP=$( curl -s https://ipinfo.io/ip/ )

# // SSH Websocket Proxy
# ssh_ws=$( systemctl status ws-epro | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
# if [[ $ssh_ws == "running" ]]; then
#     status_ws="${GREEN}ON${NC}"
# else
#     status_ws="${RED}OFF${NC}"
# fi

# // Dropbear
dropbear_service=$(/etc/init.d/dropbear status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $dropbear_service == "running" ]]; then
    status_dropbear="${GREEN}ON${NC}"
else
    status_dropbear="${RED}OFF${NC}"
fi


# // Haproxy
haproxy_service=$(systemctl status haproxy | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $haproxy_service == "running" ]]; then
    status_hap="${GREEN}ON${NC}"
else
    status_hap="${RED}OFF${NC}"
fi

# // ssh
ssh_service=$(/etc/init.d/ssh status | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $ssh_service == "running" ]]; then
    status_sshws="${GREEN}ON${NC}"
else
    status_sshws="${RED}OFF${NC}"
fi

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${GREEN}ON${NC}"
else
    status_nginx="${RED}OFF${NC}"
fi

# // SSH Websocket Proxy
xray=$(systemctl status xray | grep Active | awk '{print $3}' | cut -d "(" -f2 | cut -d ")" -f1)
if [[ $xray == "running" ]]; then
    status_xray="${GREEN}ON${NC}"
else
    status_xray="${RED}OFF${NC}"
fi

if [[ $nginx == "running" && $xray == "running" && $haproxy_service == "running" && $ssh_service == "running" && $dropbear_service == "running" ]]; then
    status_system="${GREEN}ALL IS GOOD${NC}"
else
    status_system="${RED}SYS ERROR${NC}"
fi
wget -q -O /home/version "https://raw.githubusercontent.com/rizz-code/netvpn/main/version"
newver=$(cat /home/version)
if [[ $version == $newver ]]; then
    cekupdate="${GREEN}Last Version${NC}"
else
    cekupdate="${RED}NEED UPDATE${NC}"
fi

clear
clear
clear
clear
echo -e "         ____        __    _       __  __                __ " | lolcat
echo -e "        / __ \____  / /_  (_)___  / / / /___  ____  ____/ / " | lolcat
echo -e "       / /_/ / __ \/ __ \/ / __ \/ /_/ / __ \/ __ \/ __  /  " | lolcat
echo -e "      / _, _/ /_/ / /_/ / / / / / __  / /_/ / /_/ / /_/ /   " | lolcat
echo -e "     /_/ |_|\____/_.___/_/_/ /_/_/ /_/\____/\____/\__,_/    " | lolcat
echo
echo -e "${COLOR1}   ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${COLOR1}   │                   • SERVER SERVICE •                ${NC}"
echo -e "${COLOR1}   │  ${IYellow}Premium Version   :  ${IGreen}${version} ${NC}" 
if [ "$cekup" = "day" ]; then
echo -e " ${COLOR1}  │  ${IYellow}System Uptime     :  ${ICyan}$uphours $upminutes $uptimecek${NC}"
else
echo -e " ${COLOR1}  │  ${IYellow}System Uptime     :  ${ICyan}$uphours $upminutes ${NC}"
fi
echo -e " ${COLOR1}  │  ${IYellow}OS VPS            :  "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-` $NC
echo -e " ${COLOR1}  │  ${IYellow}Memory Usage      :  ${ICyan}$uram / $tram ${NC}"
echo -e " ${COLOR1}  │  ${IYellow}CPU Usage         :  ${ICyan}$cpu_usage ${NC}"
echo -e " ${COLOR1}  │  ${IYellow}Current Domain    :  ${ICyan}$(cat /etc/xray/domain)${NC}"
echo -e " ${COLOR1}  │  ${IYellow}IP VPS            :  ${ICyan}$ipsaya${NC}"
echo -e " ${COLOR1}  │  ${IYellow}ISP VPS           :  ${ICyan}$ISP${NC}"
echo -e " ${COLOR1}  │  ${IYellow}REGION            :  ${ICyan}$(curl -s ipinfo.io/timezone )${NC}"
echo -e " ${COLOR1}  │  ${IYellow}DATE&TIME         :  ${ICyan}$( date -d "0 days" +"%d-%m-%Y | %X" ) ${NC}"
echo -e " ${COLOR1}  └─────────────────────────────────────────────────────┘${NC}"
echo -e "${COLOR1}   ┌─────────────────────────────────────────────────────┐${NC}"
echo -e " ${COLOR1}    ${IYellow}SSH-WS:${GREEN}${status_sshws}${NC} | ${IYellow}NGINX:${status_nginx} | ${IYellow}XRAY:${status_xray} | ${IYellow}DB:${status_dropbear} | ${IYellow}HAPROXY:${status_hap} "
echo -e " ${COLOR1}${NC}            .:::. .:::. ${status_system} .:::. .:::. "
echo -e " ${COLOR1}  └─────────────────────────────────────────────────────┘${NC}"
echo -e "${COLOR1}   ┌─────────────────────────────────────────────────────┐${NC}"
echo -e " ${COLOR1}    ${ICyan}SSH: ${ssh1}               ${ICyan}VMESS: ${vma}              ${ICyan}VLESS: ${vla}"
echo -e " ${COLOR1}             ${ICyan}TROJAN: ${tra}           ${ICyan}SHADOWSOCKS: ${ssa}"
echo -e " ${COLOR1}  └─────────────────────────────────────────────────────┘${NC}"
datediff "$Exp" "$DATE"
echo -e "${COLOR1}               ┌─────────────────────────────┐  ${NC}" | lolcat
echo -e "${COLOR1}                      • SCRIPT Detail •          ${NC}" | lolcat
echo -e "${COLOR1}                • Owner      : RobinHood         ${NC}" | lolcat
echo -e "${COLOR1}                • Reseller   : $reseller         ${NC}" | lolcat
echo -e "${COLOR1}                • Client     : $Name             ${NC}" | lolcat
echo -e "${COLOR1}                • Version    : ${version}        ${NC}" | lolcat
echo -e "${COLOR1}                • Up-to-Date : ${cekupdate}      ${NC}" | lolcat
echo -e "${COLOR1}                • Expiry     : ${Expiry} days left    ${NC}" | lolcat
echo -e "${COLOR1}               └─────────────────────────────┘  ${NC}" | lolcat
if [[ $cekupdate == "${RED}NEED UPDATE${NC}" ]]; then
    echo -e "${COLOR1}      ─────────────────────────────────────────────────────${NC}" | lolcat
    echo -e " ${COLOR1}               ${RED}.:::. Silahkan Update Script .:::.${NC}" 
    echo -e " ${COLOR1}       ${RED}.:::. Masuk menu lalu pilih nomor [06] / [6] .:::.${NC}" 
    echo -e " ${COLOR1}     ─────────────────────────────────────────────────────${NC}" | lolcat
else
    needupdate=" "
fi
echo -e "${COLOR1}      ───────────────────────────────────────────────${NC}" | lolcat
echo -e " ${COLOR1}        ${bold}.:::.  ${bold}Ketik ${bold}${IYellow}cmds${NC} ${bold}untuk ${bold}akses ${bold}menu .:::." 
echo -e " ${COLOR1}     ───────────────────────────────────────────────${NC}" | lolcat