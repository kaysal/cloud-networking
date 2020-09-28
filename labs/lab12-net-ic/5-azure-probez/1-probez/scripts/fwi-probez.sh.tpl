#! /bin/bash

apt-get update
apt-get install nmap -y
# probe script

touch /usr/local/bin/probez
chmod a+x /usr/local/bin/probez
cat <<EOF > /usr/local/bin/probez
nping -c ${COUNT} --tcp -p 80 ${TARGET}
EOF

echo "*/30 * * * * /usr/local/bin/probez 2>&1 > /dev/null" > /tmp/crontab.txt
crontab /tmp/crontab.txt
