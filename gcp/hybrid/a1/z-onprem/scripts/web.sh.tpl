#! /bin/bash

apt-get update
apt install -y apache2 tcpdump fping dnsutils apache2-utils jq \
python3 python3-pip
pip3 install requests
pip3 install dnspython

vm_hostname="$(curl -H "Metadata-Flavor:Google" \
http://169.254.169.254/computeMetadata/v1/instance/name)"
echo "$vm_hostname" | tee /var/www/html/index.html
systemctl restart apache2

# script
touch /tmp/list.txt
cat <<EOF > /tmp/list.txt
vm.eu1.onprem.lab
vm.eu2.onprem.lab
ns.eu1.onprem.lab
web80.spoke1.lab
web80.spoke2.lab
EOF

touch /tmp/pinger
chmod a+x /tmp/pinger
cat <<EOF > /tmp/pinger
  fping -A -f /tmp/list.txt
  echo "curl ${ILB_UNTRUST1_80}:8080 --> \$(curl -sS --connect-timeout 2 ${ILB_UNTRUST1_80}:8080)"
  echo "curl ${ILB_UNTRUST1_81}:8081 --> \$(curl -sS --connect-timeout 2 ${ILB_UNTRUST1_81}:8081)"
  echo "curl ${ILB_UNTRUST2_80}:8080 --> \$(curl -sS --connect-timeout 2 ${ILB_UNTRUST2_80}:8080)"
  echo "curl ${ILB_UNTRUST2_81}:8081 --> \$(curl -sS --connect-timeout 2 ${ILB_UNTRUST2_81}:8081)"
EOF

wget -O /tmp/private_api.py https://storage.googleapis.com/salawu-gcs/gcp/networking/private_api.py
wget -O /tmp/private_api.sh https://storage.googleapis.com/salawu-gcs/gcp/networking/private_api.sh
chmod a+x /tmp/private_api.py
chmod a+x /tmp/private_api.sh
