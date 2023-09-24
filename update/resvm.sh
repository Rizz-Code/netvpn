#!/bin/bash
source /var/lib/ch.txt
TIMES="10"
# CHATID="1855655763"
# CHATIDGC=-1001855655763
# KEY="6527620513:AAHKGPCdezTkQYyxOf0ZkktEJC6kbe-f178"
URL="https://api.telegram.org/bot$KEY/sendMessage"
domain=$(cat /etc/xray/domain)
user=${1}
exp=${2}
uuid=${3}
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /etc/xray/config.json
systemctl restart xray

TEXT="
<code>—————————————————————————</code>
<code>         INFO            </code>
<code>—————————————————————————</code>
<code>✅ Account Unlocked ✅</code>
<code>—————————————————————————</code>
<code>
Username : ${user}
Domain   : ${domain}
</code>
<code>—————————————————————————</code>

<code>Account Unlocked</code>
"

curl -s --max-time $TIMES -d "chat_id=$CHATIDGC&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL
curl -s --max-time $TIMES -d "chat_id=$CHATID&disable_web_page_preview=1&text=$TEXT&parse_mode=html" $URL