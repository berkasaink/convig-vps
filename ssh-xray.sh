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
wget -O /etc/gtea "https://github.com/berkasaink/convig-vps/raw/main/banner"
## RC local & udpgw
wget -O install-rc.sh "https://github.com/berkasaink/convig-vps/raw/main/rc-udpgw"
chmod +x install-rc.sh
bash install-rc.sh
rm install-rc.sh
##installer openvpn
cd /etc
rm -r openvpn
mkdir openvpn
cd openvpn
wget https://github.com/goenktea/idssh.my.id/raw/main/ovpn.zip && unzip ovpn.zip
rm ovpn.zip
## ws ssh
cd
wget -O /usr/bin/ws-epro "https://github.com/berkasaink/convig-vps/raw/main/ws-epro"
chmod +x /usr/bin/ws-epro
wget -O /etc/systemd/system/ws-epro.service "https://github.com/berkasaink/convig-vps/raw/main/ws-epro.service"
chmod +x /etc/systemd/system/ws-epro.service
mkdir -P /usr/local/etc/ws-epro
wget -O /usr/local/etc/ws-epro "https://github.com/berkasaink/convig-vps/raw/main/ws.yml"
##configurasi stunnel4
cd /etc/stunnel
rm stunnel.conf
wget https://raw.githubusercontent.com/berkasaink/convig-vps/main/stunnel.conf
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
wget https://github.com/berkasaink/convig-vps/raw/main/tendang && chmod +x tendang && mv tendang /usr/bin
sed -i '$ i\* * * * * root /usr/bin/tendang' /etc/crontab
sed -i '$ i\* * * * * root sleep 5; /usr/bin/tendang' /etc/crontab
sed -i '$ i\* * * * * root sleep 10; /usr/bin/tendang' /etc/crontab
sed -i '$ i\* * * * * root sleep 15; /usr/bin/tendang' /etc/crontab
sed -i '$ i\* * * * * root sleep 20; /usr/bin/tendang' /etc/crontab
sed -i '$ i\* * * * * root sleep 25; /usr/bin/tendang' /etc/crontab
sed -i '$ i\* * * * * root sleep 30; /usr/bin/tendang' /etc/crontab
sed -i '$ i\* * * * * root sleep 35; /usr/bin/tendang' /etc/crontab
sed -i '$ i\* * * * * root sleep 40; /usr/bin/tendang' /etc/crontab
sed -i '$ i\* * * * * root sleep 45; /usr/bin/tendang' /etc/crontab
sed -i '$ i\* * * * * root sleep 50; /usr/bin/tendang' /etc/crontab
sed -i '$ i\* * * * * root sleep 55; /usr/bin/tendang' /etc/crontab
cd /usr/bin
wget https://github.com/goenktea/idssh.my.id/raw/main/menu.zip && unzip menu.zip && rm menu.zip
#menu xray
cd /usr/local/etc/xray
rm config.json
wget -O config.json https://raw.githubusercontent.com/berkasaink/convig-vps/main/config-xray.json
cd
wget  https://www.dropbox.com/s/31kdkdqqs0h5kqu/koman.sh && bash koman.sh
rm koman.sh
cd /usr/bin
mv addray v2ray-add
mv del-vmess v2ray-delete
cp exp-vmess v2ray-expired
cd
cd /etc/nginx
rm -r conf.d
mkdir conf.d
cd conf.d
wget https://raw.githubusercontent.com/berkasaink/convig-vps/main/xray.conf
cd
mkdir -p /etc/GoenkTea
wget -O /etc/GoenkTea/cert.pem "https://github.com/berkasaink/convig-vps/raw/main/cert.pem"
wget -O /etc/GoenkTea/key.key "https://github.com/berkasaink/convig-vps/raw/main/key.key"
cat /etc/GoenkTea/* >> /etc/GoenkTea/stunnel.pem
systemctl restart rc-local
systemctl restart sslh
systemctl restart nginx
systemctl enable xray
systemctl start xray
systemctl restart xray
/etc/init.d/stunnel4 restart
systemctl daemon-reload
systemctl enable ws-epro
systemctl start ws-epro
systemctl restart ws-epro
