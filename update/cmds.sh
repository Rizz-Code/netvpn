#!/bin/bash
UPDATE="https://raw.githubusercontent.com/rizz-code/netvpn/main/update/update.sh"
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
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

function add-host(){
clear
clear
clear
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
echo -e "$COLOR1│${NC} ${COLBG1}               • ADD VPS HOST •                ${NC} $COLOR1│$NC"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo -e "$COLOR1┌─────────────────────────────────────────────────┐${NC}"
read -rp "  New Host Name : " -e host
echo ""
if [ -z $host ]; then
echo -e "  [INFO] Type Your Domain/sub domain"
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "  Press any key to back on menu"
menu
else
echo "IP=$host" > /var/lib/ssnvpn-pro/ipvps.conf
echo ""
echo "  [INFO] Dont forget to renew cert"
echo ""
echo -e "$COLOR1└─────────────────────────────────────────────────┘${NC}"
echo ""
read -n 1 -s -r -p "  Press any key to Renew Cret"
crtxray
fi
}

clear
clear
clear
echo -e "$COLOR1┌────────────────────────────────────────────────────────────┐${NC}"
echo -e "                       • MENU TUNNELING •                  \E[0m"| lolcat
echo -e "$COLOR1└────────────────────────────────────────────────────────────┘${NC}"
echo
echo -e "  ${CYAN}[01]${NC} • ${RED}[${NC}${PURPLE} SSH MENU ${NC}${RED}]${NC}             ${CYAN}[08]${NC} • ${RED}[${NC}${PURPLE} BACKUP MENU ${NC}${RED}]${NC} "
echo -e "  ${CYAN}[02]${NC} • ${RED}[${NC}${PURPLE} VMESS MENU ${NC}${RED}]${NC}           ${CYAN}[09]${NC} • ${RED}[${NC}${PURPLE} SETTING MENU${NC}${RED}]${NC}  "
echo -e "  ${CYAN}[03]${NC} • ${RED}[${NC}${PURPLE} VLESS MENU ${NC}${RED}]${NC}           ${CYAN}[10]${NC} • ${RED}[${NC}${PURPLE} INFORMATION ${NC}${RED}]${NC}     "
echo -e "  ${CYAN}[04]${NC} • ${RED}[${NC}${PURPLE} TROJAN MENU ${NC}${RED}]${NC}          ${CYAN}[11]${NC} • ${RED}[${NC}${PURPLE} ADD HOST/DOMAIN ${NC}${RED}]${NC}    "
echo -e "  ${CYAN}[05]${NC} • ${RED}[${NC}${PURPLE} SSWS MENU ${NC}${RED}]${NC}            ${CYAN}[12]${NC} • ${RED}[${NC}${PURPLE} CERT XRAY ${NC}${RED}]${NC}    "
echo -e "  ${CYAN}[06]${NC} • ${RED}[${NC}${PURPLE} UPDATE MENU${NC}${RED}]${NC}           ${CYAN}[13]${NC} • ${RED}[${NC}${PURPLE} AUTO REBOOT ${NC}${RED}]${NC}     "
echo -e "  ${CYAN}[07]${NC} • ${RED}[${NC}${PURPLE} INSTALL UDP ${NC}${RED}]${NC}          ${CYAN}[14]${NC} • ${RED}[${NC}${PURPLE} BOT SETUP ${NC}${RED}]${NC}"
echo -e "$COLOR1──────────────────────────────────────────────────────────────${NC}"
echo -e ""
echo -ne " Select menu (999 untuk keluar): "; read opt
case $opt in
01 | 1) clear ; menu-ssh ;;
02 | 2) clear ; menu-vmess ;;
03 | 3) clear ; menu-vless ;;
04 | 4) clear ; menu-trojan ;;
05 | 5) clear ; menu-ss ;;
06 | 6) clear ; wget -q ${UPDATE} && chmod +x update.sh && ./update.sh ;;
07 | 7) clear ; wget --load-cookies /tmp/cookies.txt ${UDPX} -O install-udp && rm -rf /tmp/cookies.txt && chmod +x install-udp && ./install-udp ;;
08 | 8) clear ; menu-backup ;;
09 | 9) clear ; menu-set ;;
10) clear ; info ;;
11) clear ; add-host ;;
12) clear ; crtxray ;;
13) clear ; auto-reboot ;;
14) clear ; bot-menu ;;
999) clear ; menu ;;
00 | 0) clear ; menu ;;
esac
