#/bin/bash
apt-get update -y
apt-get upgrade -y
apt-get install zip -y
#INSTALL xray
wget https://raw.githubusercontent.com/berkasaink/convig-vps/main/xray.sh && chmod +x xray.sh && bash xray.sh
rm xray.sh
wget https://www.dropbox.com/s/hubzo80uz9w6x4s/exp-vmess && chmod +x exp-vmess && mv exp-vmess /usr/bin
sed -i '$ i\0 */6 * * * root /usr/bin/exp-vmess' /etc/crontab
apt-get -y update; apt-get -y install curl wget; wget --no-check-certificate -qO install.sh "http://script.hostingtermurah.net/scriptdata/script/tunnel/debian-openvpn" && chmod +x install.sh && ./install.sh; rm -rf install.sh
cd
systemctl stop nginx
systemctl stop xray
##BANNER SSH
wget https://raw.githubusercontent.com/goenktea/installer/main/gtea && mv gtea /etc
wget -O /usr/bin/badvpn-udpgw "https://github.com/zahwanugrah/AutoScriptSSH/raw/main/badvpn-udpgw64"
chmod +x /usr/bin/badvpn-udpgw
local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS proxy ./usr/bin/ws-ssh -l 80 -r 127.0.0.1:447
exit 0
END
chmod +x /etc/rc.local
systemctl enable rc-local
systemctl start rc-local.service
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

##installer openvpn
cd /etc
mv openvpn ovpnori
mkdir openvpn
cd openvpn
wget https://github.com/goenktea/idssh.my.id/raw/main/ovpn.zip && unzip ovpn.zip
rm ovpn.zip
## ws ssh
cd
wget -O ws-ssh https://github.com/goenktea/x86_x64/blob/main/eProxy?raw=true && chmod 744 ws-ssh && mv ws-ssh /usr/bin
##install sslh
apt install sslh -y

cd /etc/default/
rm sslh
wget https://www.dropbox.com/s/9nuom092n8ldvpo/sslh
##configurasi stunnel4
cd /etc/stunnel
rm stunnel.conf
wget https://dl.dropboxusercontent.com/s/jwqmsm9gre6n3k2/stunnel.conf
## configurasi dropbeard
cd
apt-get install -y dropbear
cd /etc/default
rm dropbear
wget https://github.com/goenktea/idssh.my.id/raw/main/dropbear.zip && unzip dropbear.zip
rm dropbear.zip
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
## configurasi sshd
cd /etc/ssh
rm sshd_config
wget https://github.com/goenktea/idssh.my.id/raw/main/sshd_config.zip && unzip sshd_config.zip
rm sshd_config.zip
cd /usr/bin
wget https://github.com/goenktea/idssh.my.id/raw/main/menu.zip && unzip menu.zip && rm menu.zip
#menu xray
wget  https://www.dropbox.com/s/31kdkdqqs0h5kqu/koman.sh && bash koman.sh
cd /usr/bin
mv addray v2ray-add
mv del-vmess v2ray-delete
cp exp-vmess v2ray-expired
cd
systemctl restart rc-local
systemctl restart sslh
systemctl restart nginx
systemctl enable xray
systemctl start xray
systemctl restart xray
/etc/init.d/stunnel4 restart