#!/bin/bash
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
###########- COLOR CODE -##############
# if [[ -f /etc/ssnvpn/github/api && -f /etc/ssnvpn/github/email && /etc/ssnvpn/github/username ]]; then
#    rec=""
# else
#     mkdir /etc/ssnvpn/github > /dev/null 2>&1
#     echo "devrizzstore@gmail.com" > /etc/ssnvpn/github/email
#     echo "Rizz-Code" > /etc/ssnvpn/github/username
#     echo "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" > /etc/ssnvpn/github/api
#     echo "ON" > /etc/ssnvpn/github/gitstat
# fi

function first_setup(){
    echo -e "Installing HA-Proxy"
    if [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "ubuntu" ]]; then
    echo "Setup Dependencies $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
    sudo apt update -y
    apt-get install --no-install-recommends software-properties-common
    add-apt-repository ppa:vbernat/haproxy-2.0 -y
    apt-get -y install haproxy=2.0.\*
elif [[ $(cat /etc/os-release | grep -w ID | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/ID//g') == "debian" ]]; then
    echo "Setup Dependencies For OS Is $(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g')"
    curl https://haproxy.debian.net/bernat.debian.org.gpg |
        gpg --dearmor >/usr/share/keyrings/haproxy.debian.net.gpg
    echo deb "[signed-by=/usr/share/keyrings/haproxy.debian.net.gpg]" \
        http://haproxy.debian.net buster-backports-1.8 main \
        >/etc/apt/sources.list.d/haproxy.list
    sudo apt-get update
    apt-get -y install haproxy=1.8.\*
else
    echo -e " Your OS Is Not Supported ($(cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/=//g' | sed 's/"//g' | sed 's/PRETTY_NAME//g') )"
    # exit 1
fi
}

function haconf(){
echo -e "Seting conf haproxy"
rm -fr /etc/haproxy/haproxy.cfg
cat >/etc/haproxy/haproxy.cfg <<EOF
global
    daemon
    maxconn 256
defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms
frontend ssh-ssl
    bind *:443 ssl crt /etc/haproxy/hap.pem
    mode tcp
    option tcplog
    default_backend ssh-backend
backend ssh-backend
    mode tcp
    option tcplog
    server ssh-server 127.0.0.1:22
frontend ssh-websocket
    bind *:443 ssl crt /etc/haproxy/hap.pem
    mode http
    option httplog
    default_backend nginx-backend
backend nginx-backend
    mode http
    option httplog
    server nginx-server 127.0.0.1:80
EOF
cat /etc/xray/xray.crt /etc/xray/xray.key | tee /etc/haproxy/hap.pem
systemctl restart haproxy
echo -e "DONE"
clear
}

function haproxycek(){
	if dpkg -l | grep -q haproxy; then
		echo "Package HAProxy sudah terinstal."
	else
		first_setup
		haconf
	  # Memeriksa apakah instalasi berhasil
	if [ $? -eq 0 ]; then
	    echo "Paket HAProxy berhasil diinstal."
	else
	    echo "Gagal menginstal paket HAProxy."
	fi
fi
}

echo -e " [INFO] System Update"
sudo apt-get install at -y > /dev/null 2>&1
sleep 2
haproxycek
echo -e " [INFO] Downloading Update File"
sleep 2
wget -q -O /usr/bin/menu "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu.sh" && chmod +x /usr/bin/menu
wget -q -O /usr/bin/menu-ss "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-ss.sh" && chmod +x /usr/bin/menu-ss
wget -q -O /usr/bin/menu-vmess "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-vmess.sh" && chmod +x /usr/bin/menu-vmess
wget -q -O /usr/bin/menu-vless "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-vless.sh" && chmod +x /usr/bin/menu-vless
wget -q -O /usr/bin/menu-trojan "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-trojan.sh" && chmod +x /usr/bin/menu-trojan
wget -q -O /usr/bin/menu-bot "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-bot.sh" && chmod +x /usr/bin/menu-bot
wget -q -O /usr/bin/menu-ssh "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-ssh.sh" && chmod +x /usr/bin/menu-ssh
wget -q -O /usr/bin/menu-set "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-set.sh" && chmod +x /usr/bin/menu-set
wget -q -O /usr/bin/menu-theme "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-theme.sh" && chmod +x /usr/bin/menu-theme
wget -q -O /usr/bin/menu-backup "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-backup.sh" && chmod +x /usr/bin/menu-backup
wget -q -O /usr/bin/menu-ip "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-ip.sh" && chmod +x /usr/bin/menu-ip
wget -q -O /usr/bin/menu-tor "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-tor.sh" && chmod +x /usr/bin/menu-tor
wget -q -O /usr/bin/auto-reboot "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/auto-reboot.sh" && chmod +x /usr/bin/auto-reboot
wget -q -O /usr/bin/menu-tcp "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-tcp.sh" && chmod +x /usr/bin/menu-tcp
wget -q -O /usr/bin/rebootvps "https://raw.githubusercontent.com/rizz-code/netvpn/main/corn/rebootvps.sh" && chmod +x /usr/bin/rebootvps
wget -q -O /usr/bin/menu-dns "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-dns.sh" && chmod +x /usr/bin/menu-dns
wget -q -O /usr/bin/info "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/info.sh" && chmod +x /usr/bin/info
wget -q -O /usr/bin/mspeed "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-speedtest.sh" && chmod +x /usr/bin/mspeed
wget -q -O /usr/bin/mspeed2 "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-speedtest2.sh" && chmod +x /usr/bin/mspeed2
wget -q -O /usr/bin/mbandwith "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/menu-bandwith.sh" && chmod +x /usr/bin/mbandwith
wget -q -O /usr/bin/cmds "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/cmds.sh" && chmod +x /usr/bin/cmds
wget -q -O /usr/bin/limitqouta "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/limitqouta.sh" && chmod +x /usr/bin/limitqouta
wget -q -O /usr/bin/bdsm "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/bdsm.sh" && chmod +x /usr/bin/bdsm
wget -q -O /usr/bin/xp "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/xp.sh" && chmod +x /usr/bin/xp
wget -q -O /usr/bin/limiter "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/limiter.sh" && chmod +x /usr/bin/limiter
wget -q -O /usr/bin/resvm "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/resvm.sh" && chmod +x /usr/bin/resvm
wget -q -O /usr/bin/bot-menu "https://raw.githubusercontent.com/rizz-code/netvpn/main/update/bot-menu.sh" && chmod +x /usr/bin/bot-menu
wget -q -O /home/ver "https://raw.githubusercontent.com/rizz-code/netvpn/main/version"

cat >/var/lib/ch.txt<< EOF
CHATID=-1001785786113
CHATIDGC=-1001855655763
KEY="6527620513:AAHKGPCdezTkQYyxOf0ZkktEJC6kbe-f178"
EOF

cat >/etc/systemd/system/limitqouta@.service << EOF
[Unit]
Description=Limit Qouta
After=network.target

[Service]
WorkingDirectory=/usr/bin/
ExecStart=limitqouta %i
Restart=always

[Install]
WantedBy=multi-user.target
EOF

cat >/etc/cron.d/limmiter <<-END
	SHELL=/bin/sh
	PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
	* * * * * root /usr/bin/limiter
END

cat >/etc/cron.d/xp_all <<-END
	SHELL=/bin/sh
	PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
	* * * * * root /usr/bin/xp
END

systemctl enable limitqouta@vmess
systemctl enable limitqouta@trojan
systemctl enable limitqouta@vless
systemctl restart limitqouta@vmess
systemctl restart limitqouta@vless
systemctl restart limitqouta@trojan
echo -e " [INFO] Update Successfully"
sleep 2
rm -f update.sh
echo -e " [INFO] Silahkan ketik (menu)"
exit
