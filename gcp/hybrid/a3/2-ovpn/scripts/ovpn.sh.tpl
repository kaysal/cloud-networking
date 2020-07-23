#! /bin/bash

apt-get update
apt install -y tcpdump openvpn easy-rsa

touch /usr/local/bin/configz
chmod a+x /usr/local/bin/configz
cat <<EOF > /usr/local/bin/configz
#!/bin/bash

echo ""
echo "----------|  1. Set up the CA  |----------"
echo ""

make-cadir ~/openvpn-ca
cd ~/openvpn-ca
sed -i '/export KEY_COUNTRY=.*/c\export KEY_COUNTRY=${KEY_COUNTRY}' vars
sed -i '/export KEY_PROVINCE=.*/c\export KEY_PROVINCE=${KEY_PROVINCE}' vars
sed -i '/export KEY_CITY=.*/c\export KEY_CITY=${KEY_CITY}' vars
sed -i '/export KEY_ORG=.*/c\export KEY_ORG=${KEY_ORG}' vars
sed -i '/export KEY_EMAIL=.*/c\export KEY_EMAIL=${KEY_EMAIL}' vars
sed -i '/export KEY_NAME=.*/c\export KEY_NAME=${KEY_NAME}' vars
source vars
./clean-all
./build-ca --batch
./build-key-server --batch server
./build-dh
openvpn --genkey --secret keys/tiv.key
echo "done!"

echo ""
echo "----------|  2. Generate Client Certificates  |----------"
echo ""
./build-key --batch ${CLIENT1}
./build-key --batch ${CLIENT2}
echo "done!"

echo ""
echo "----------|  3. Setup Openvpn Server  |----------"
echo ""
cd ~/openvpn-ca/keys
sudo cp ca.crt server.crt server.key tiv.key dh2048.pem /etc/openvpn
sudo gunzip -c /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz | sudo tee /etc/openvpn/server.conf
cd /etc/openvpn
sudo sed -i '/;tls-auth ta.key/c\tls-auth tiv.key\nkey-direction 0' server.conf
sudo sed -i '/;cipher AES-128-CBC/c\cipher AES-128-CBC\nauth SHA256' server.conf
sudo sed -i '/;user nobody/c\user nobody' server.conf
sudo sed -i '/;group nogroup/c\group nogroup' server.conf
sudo sed -i '/port 1194/c\port 443' server.conf
sudo sed -i '/;proto tcp/c\proto tcp' server.conf
sudo sed -i '/proto udp/c\;proto udp' server.conf
sudo sed -i '/;push "redirect-gateway def1 bypass-dhcp"/c\push "redirect-gateway def1 bypass-dhcp"' server.conf
sudo sed -i '/;push "dhcp-option DNS 208.67.222.222"/c\push "dhcp-option DNS 208.67.222.222"' server.conf
sudo sed -i '/;push "dhcp-option DNS 208.67.220.220"/c\push "dhcp-option DNS 208.67.220.220"' server.conf
sudo sed -i '/;client-to-client/c\client-to-client' server.conf
sudo sed -i '/;push "route 192.168.20.0 255.255.255.0"/c\;push "route 192.168.20.0 255.255.255.0"\
\npush "route ${SERVER_LAN1}"\npush "route ${SERVER_LAN2}"\npush "route ${SERVER_LAN3}"' server.conf
echo "done!"

echo ""
echo "----------|  4. Configure Ubuntu  |----------"
echo ""
sudo sed -i '/#net.ipv4.ip_forward=1/c\net.ipv4.ip_forward=1' /etc/sysctl.conf
sudo sysctl -p

sudo sed -i "/# Don't delete these required lines.*/c\\
# OPENVPN\n# NAT Table\n*nat\n:POSTROUTING ACCEPT [0:0]\
\n# OpenVPN client traffic\
\n-A POSTROUTING -s ${CLIENT_RANGE} -o ens4 -j MASQUERADE\
\nCOMMIT\
\n# OPENVPN\n\n# Don't delete these required lines, otherwise there will be errors" \
/etc/ufw/before.rules
sudo sed -i '/DEFAULT_FORWARD_POLICY=.*/c\DEFAULT_FORWARD_POLICY="ACCEPT"' /etc/default/ufw
echo "done!"

sudo ufw allow 443/tcp
sudo ufw allow OpenSSH
sudo ufw disable
echo "y" | sudo ufw enable

echo ""
echo "----------|  5. Run OpenVPN  |----------"
echo ""
sudo systemctl start openvpn@server
sudo systemctl status openvpn@server
echo "done!"

echo ""
echo "----------|  6. Set up Linux Client Config Structure  |----------"
echo ""
mkdir -p ~/clients/files
chmod 700 ~/clients/files
cd ~/clients/
cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf linux-client.conf
sudo sed -i '/my-server-1/c\remote ${SERVER_EXT_IP} 443' linux-client.conf
sudo sed -i '/;proto tcp/c\proto tcp' linux-client.conf
sudo sed -i '/proto udp/c\;proto udp' linux-client.conf
sudo sed -i '/;user nobody/c\user nobody' linux-client.conf
sudo sed -i '/;group nogroup/c\group nogroup' linux-client.conf
sudo sed -i '/ca ca.crt/c\# ca ca.crt' linux-client.conf
sudo sed -i '/cert client.crt/c\# cert client.crt' linux-client.conf
sudo sed -i '/key client.key/c\# key client.key' linux-client.conf
echo "" >> linux-client.conf
echo "# custom config" >> linux-client.conf
echo cipher AES-128-CBC >> linux-client.conf
echo auth SHA256 >> linux-client.conf
echo key-direction 1 >> linux-client.conf
echo "# additional linux client config" >> linux-client.conf
echo script-security 2 >> linux-client.conf
echo up /etc/openvpn/update-resolv-conf >> linux-client.conf
echo down /etc/openvpn/update-resolv-conf >> linux-client.conf
echo "done!"

echo ""
echo "----------|  7. Set up Default Client Config Structure  |----------"
echo ""
cd ~/clients/
cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf default-client.conf
sudo sed -i '/my-server-1/c\remote ${SERVER_EXT_IP} 443' default-client.conf
sudo sed -i '/;proto tcp/c\proto tcp' default-client.conf
sudo sed -i '/proto udp/c\;proto udp' default-client.conf
sudo sed -i '/;user nobody/c\user nobody' default-client.conf
sudo sed -i '/;group nogroup/c\group nogroup' default-client.conf
sudo sed -i '/ca ca.crt/c\# ca ca.crt' default-client.conf
sudo sed -i '/cert client.crt/c\# cert client.crt' default-client.conf
sudo sed -i '/key client.key/c\# key client.key' default-client.conf
echo "" >> default-client.conf
echo "# custom config" >> default-client.conf
echo cipher AES-128-CBC >> default-client.conf
echo auth SHA256 >> default-client.conf
echo key-direction 1 >> default-client.conf
echo "done!"

echo ""
echo "----------|  8. Generate Linux Client Config  |----------"
echo ""
wget -O ~/clients/gen_config.sh https://storage.googleapis.com/salawu-gcs/gcp/networking/openvpn/gen_config.sh
chmod a+x ~/clients/gen_config.sh
cd ~/clients
sudo ./gen_config.sh ${CLIENT1} linux-client.conf
sudo ./gen_config.sh ${CLIENT2} default-client.conf
#cat ~/clients/files/${CLIENT1}.ovpn
#cat ~/clients/files/${CLIENT2}.ovpn
echo ""
echo "Download client openvpn files:"
echo ""
echo "${CLIENT1}: gcloud compute scp ${SERVER_NAME}:/home/$(whoami)/clients/files/${CLIENT1}.ovpn ."
echo "${CLIENT2}: gcloud compute scp ${SERVER_NAME}:/home/$(woami)/clients/files/${CLIENT2}.ovpn ."
echo ""
echo "done!"
EOF

# configz
