#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
colornow=$(cat /etc/ssnvpn/theme/color.conf)
NC="\e[0m"
RED="\033[0;31m"
COLOR1="\033[1;36m"
COLBG1="\e[1;97;101m"                 
###########- END COLOR CODE -##########
source /var/lib/ch.txt
AKUN="AKUN VLESS"
TIMES="10"
# CHATID="1855655763"
# CHATIDGC=-1001855655763
# KEY="6527620513:AAHKGPCdezTkQYyxOf0ZkktEJC6kbe-f178"
URL="https://api.telegram.org/bot$KEY/sendMessage"
MYIP=$(curl -sS ipv4.icanhazip.com)
OWNER=$(curl -sS https://accessvpn.onrender.com | grep $MYIP | awk '{print $2}')

function cekvless(){
clear
echo -n > /tmp/other.txt
data=( `cat /etc/xray/config.json | grep '#&' | cut -d ' ' -f 2 | sort | uniq`);
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${COLBG1}          • RENEW VLESS USER •          ${NC} "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"

for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi

echo -n > /tmp/ipvless.txt
data2=( `cat /var/log/xray/access.log | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | sort | uniq`);
for ip in "${data2[@]}"
do

jum=$(cat /var/log/xray/access.log | grep -w "$akun" | tail -n 500 | cut -d " " -f 3 | sed 's/tcp://g' | cut -d ":" -f 1 | grep -w "$ip" | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvless.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvless.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done

jum=$(cat /tmp/ipvless.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvless.txt | nl)
echo -e "   user : $akun";
echo -e "   $jum2";
fi
rm -rf /tmp/ipvless.txt
done

rm -rf /tmp/other.txt
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
}

function renewvless(){
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${COLBG1}          • RENEW VLESS USER •          ${NC} "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "  • You have no existing clients!"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${COLBG1}           • RENEW VLESS USER •         ${NC} "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e ""
echo -e "  • [NOTE] Press any key to back on menu"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vless
else
read -p "   Expired (days): " masaaktif
if [ -z $masaaktif ]; then
masaaktif="1"
fi
exp=$(grep -E "^#& $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
now=$(date +%Y-%m-%d)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
exp3=$(($exp2 + $masaaktif))
exp4=`date -d "$exp3 days" +"%Y-%m-%d"`
sed -i "/#& $user/c\#& $user $exp4" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${COLBG1}           • RENEW VLESS USER •         ${NC} "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "   [INFO]  $user Account Renewed Successfully"
echo -e "   "
echo -e "   Client Name : $user"
echo -e "   Days Added  : $masaaktif Days"
echo -e "   Expired On  : $exp4"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
}

function delvless(){
    clear
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${COLBG1}          • DELETE VLESS USER •         ${NC} "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "  • You Dont have any existing clients!"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${COLBG1}          • DELETE VLESS USER •         ${NC} "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq | nl
echo -e ""
echo -e "  • [NOTE] Press any key to back on menu"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
read -rp "   Input Username : " user
if [ -z $user ]; then
menu-vless
else
exp=$(grep -wE "^#& $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
sed -i "/^#& $user $exp/,/^},{/d" /etc/xray/config.json
systemctl restart xray > /dev/null 2>&1
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${COLBG1}          • DELETE VLESS USER •         ${NC} "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "   • Accound Delete Successfully"
echo -e ""
echo -e "   • Client Name : $user"
echo -e "   • Expired On  : $exp"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu-vless
fi
}

function trialvless(){
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
user=trial`</dev/urandom tr -dc X-Z0-9 | head -c4`
uuid=$(cat /proc/sys/kernel/random/uuid)
domain=$(cat /etc/xray/domain)
masaaktif=1
# Quota=1
iplim=1
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/vlessws&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=/vlessws&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}"
if [ ! -e /etc/vless ]; then
  mkdir -p /etc/vless
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/vless/${user}
fi
DATADB=$(cat /etc/vless/.vless.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/vless/.vless.db
fi
echo "### ${user} ${exp} ${uuid}" >>/etc/vless/.vless.db
clear
systemctl restart xray
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${COLBG1}          • TRIAL VLESS USER •         ${NC} "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " Remarks       : ${user}" 
echo -e " Expired On    : $exp" 
# echo -e " User Quota    : ${Quota} GB"
echo -e " Limit User(IP): ${iplim} "
echo -e " Domain        : ${domain}" 
echo -e " port TLS      : $tls" 
echo -e " port none TLS : $none" 
echo -e " id            : ${uuid}"
echo -e " Encryption    : none" 
echo -e " Network       : ws" 
echo -e " Path          : /vless" 
echo -e " Path WSS      : wss://bug.com/vless" 
echo -e " Path          : vless-grpc" 
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " Link TLS :"
echo -e " ${vlesslink1}" 
echo -e ""   
echo -e " Link none TLS : "
echo -e " ${vlesslink2}" 
echo -e ""
echo -e " Link GRPC : "
echo -e " ${vlesslink3}" 
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "" 
read -n 1 -s -r -p "   Press any key to back on menu"
TRX="
<code>INFO MASKU -Transaksi</code>
<code>────────────────────</code>
<b>  ⚠️TRANSAKSI TRIAL VLESS⚠️      </b>
<code>────────────────────</code>
<code>🌟Owner   : $OWNER</code>
<code>🌟Detail  : $AKUN</code>
<code>🌟Durasi  : $exp</code>
<code>🌟Server  : $domen</code>
<code>────────────────────</code>
<i>Notifikasi Via RizzBOT</i>
<b>Tele : @Akusiapaoiii</b>
"
curl -s --max-time $TIMES -d "chat_id=$CHATIDGC&disable_web_page_preview=1&text=$TRX&parse_mode=html" $URL
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TRX&parse_mode=html" $URL
menu-vless
}

function addvless(){
domain=$(cat /etc/xray/domain)
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${COLBG1}          • CREATE VLESS USER •         ${NC} "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"
until [[ $user =~ ^[a-zA-Z0-9_]+$ && ${CLIENT_EXISTS} == '0' ]]; do
		read -rp "  Input Username : " -e user
        if [ -z $user ]; then
echo -e " [Error] Username cannot be empty "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
		CLIENT_EXISTS=$(grep -w $user /etc/xray/config.json | wc -l)

if [[ ${CLIENT_EXISTS} == '1' ]]; then
echo -e " Please choose another name."
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo ""
read -n 1 -s -r -p "   Press any key to back on menu"
menu
fi
done

uuid=$(cat /proc/sys/kernel/random/uuid)
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${COLBG1}          • CREATE VLESS USER •         ${NC} "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "Setup Limit Quota/ip for Account"
echo -e "0 For Unlimited/No Limit"
echo ""
echo -e "   Username       : ${user}"
# read -p "   Limit User (GB): " Quota
read -p "   Limit User (IP): " iplim
read -p "   Expired (days) : " masaaktif
mkdir -p /etc/vless/limit-ip
echo ${iplim} >> /etc/vless/limit-ip/${user}
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\#& '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:$tls?path=/vlessws&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:$none?path=/vlessws&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:$tls?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}"
if [ ! -e /etc/vless ]; then
  mkdir -p /etc/vless
fi

if [ -z ${Quota} ]; then
  Quota="0"
fi

c=$(echo "${Quota}" | sed 's/[^0-9]*//g')
d=$((${c} * 1024 * 1024 * 1024))

if [[ ${c} != "0" ]]; then
  echo "${d}" >/etc/vless/${user}
fi
DATADB=$(cat /etc/vless/.vless.db | grep "^###" | grep -w "${user}" | awk '{print $2}')
if [[ "${DATADB}" != '' ]]; then
  sed -i "/\b${user}\b/d" /etc/vless/.vless.db
fi
echo "### ${user} ${exp} ${uuid}" >>/etc/vless/.vless.db
clear

systemctl restart xray
systemctl restart nginx
clear
clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " ${COLBG1}          • CREATE VLESS USER •         ${NC} "
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " Remarks       : ${user}" 
echo -e " Expired On    : $exp" 
# echo -e " User Quota    : ${Quota} GB"
echo -e " Limit User(IP): ${iplim} "
echo -e " Domain        : ${domain}" 
echo -e " port TLS      : $tls" 
echo -e " port none TLS : $none" 
echo -e " id            : ${uuid}"
echo -e " Encryption    : none" 
echo -e " Network       : ws" 
echo -e " Path          : /vless" 
echo -e " Path WSS      : wss://bug.com/vless" 
echo -e " Path          : vless-grpc" 
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " Link TLS :"
echo -e " ${vlesslink1}" 
echo -e ""   
echo -e " Link none TLS : "
echo -e " ${vlesslink2}" 
echo -e ""
echo -e " Link GRPC : "
echo -e " ${vlesslink3}" 
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo "" 
read -n 1 -s -r -p "   Press any key to back on menu"
TRX="
<code>INFO MASKU -Transaksi</code>
<code>────────────────────</code>
<b>  ⚠️TRANSAKSI SSH VLESS⚠️      </b>
<code>────────────────────</code>
<code>🌟Owner   : $OWNER</code>
<code>🌟Detail  : $AKUN</code>
<code>🌟Durasi  : $exp</code>
<code>🌟Server  : $domen</code>
<code>────────────────────</code>
<i>Notifikasi Via RizzBOT</i>
<b>Tele : @Akusiapaoiii</b>
"
curl -s --max-time $TIMES -d "chat_id=$CHATIDGC&disable_web_page_preview=1&text=$TRX&parse_mode=html" $URL
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TRX&parse_mode=html" $URL
menu-vless
}


clear
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e " \e[1;97;101m            MENU MANAGER VLESS          \E[0m"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e "\033[1;93m〔⎆〕 ${grenbo}1.${NC} \033[0;36mCreating a Vless Account${NC}"
echo -e "\033[1;93m〔⎆〕 ${grenbo}2.${NC} \033[0;36mTrial a Vless Account${NC}"
echo -e "\033[1;93m〔⎆〕 ${grenbo}3.${NC} \033[0;36mRenew a Vless Account${NC}"
echo -e "\033[1;93m〔⎆〕 ${grenbo}4.${NC} \033[0;36mDelete a Vless Account${NC}"
echo -e "\033[1;93m〔⎆〕 ${grenbo}5.${NC} \033[0;36mCek Login Vless Account${NC}"
echo -e "\033[1;93m〔⎆〕 ${grenbo}0.${NC} \033[0;36mGo Back Menu${NC}"
echo -e "\033[1;36m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[0m"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
01 | 1) clear ; addvless ;;
02 | 2) clear ; trialvless ;;
03 | 3) clear ; renewvless ;;
04 | 4) clear ; delvless ;;
05 | 5) clear ; cekvless ;;
00 | 0) clear ; menu ;;
*) clear ; menu-vless ;;
esac

       
