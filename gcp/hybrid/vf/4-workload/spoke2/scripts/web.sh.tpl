#! /bin/bash

apt-get update
apt install -y apache2 tcpdump fping dnsutils apache2-utils jq libxml2-utils \
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
10.5.1.80
10.5.2.80
172.16.2.10
EOF

touch /usr/local/bin/pinger
chmod a+x /usr/local/bin/pinger
cat <<EOF > /usr/local/bin/pinger
  fping -A -f /tmp/list.txt
  echo "curl ${SPOKE1_8080} --> \$(curl -sS --connect-timeout 2 ${SPOKE1_8080})"
  echo "curl ${SPOKE1_8081} --> \$(curl -sS --connect-timeout 2 ${SPOKE1_8081})"
  echo "curl ${SPOKE2_8080} --> \$(curl -sS --connect-timeout 2 ${SPOKE2_8080})"
  echo "curl ${SPOKE2_8081} --> \$(curl -sS --connect-timeout 2 ${SPOKE2_8081})"
EOF

COMPUTE=https://www.googleapis.com/compute/v1/projects
STORAGE=https://www.googleapis.com/storage/v1/b?project
touch /tmp/curlz
chmod a+x /tmp/curlz
cat <<EOF > /tmp/curlz
  echo ""
  echo "------ SPOKE 1 ------"
  echo ""
  curl -sS -X GET -H "Authorization:Bearer \$SPOKE1_TOKEN" \
  $STORAGE=${SPOKE1_PROJECT_ID} 2>&1
  curl -X GET -H "Authorization: Bearer \$SPOKE1_TOKEN" \
  https://storage.googleapis.com/${PREFIX}${SPOKE1_PROJECT_ID} | xmllint --format -
  echo ""
  echo "------ SPOKE 2 ------"
  echo ""
  curl -sS -X GET -H "Authorization:Bearer \$SPOKE2_TOKEN" \
  $STORAGE=${SPOKE2_PROJECT_ID} 2>&1
  echo ""
  curl -X GET -H "Authorization: Bearer \$SPOKE2_TOKEN" \
    https://storage.googleapis.com/${PREFIX}${SPOKE2_PROJECT_ID} | xmllint --format -
EOF

wget -O /tmp/private_api.py https://storage.googleapis.com/salawu-gcs/gcp/networking/private_api.py
wget -O /tmp/private_api.sh https://storage.googleapis.com/salawu-gcs/gcp/networking/private_api.sh
chmod a+x /tmp/private_api.py
chmod a+x /tmp/private_api.sh
