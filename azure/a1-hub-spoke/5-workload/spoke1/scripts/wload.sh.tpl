#! /bin/bash

apt update
apt install -y tcpdump fping dnsutils walinuxagent apache2 apache2-utils jq

export instance=$(curl -s \
-H Metadata:true \
"http://169.254.169.254/metadata/instance?api-version=2019-03-11")

cat <<EOF > /var/www/html/index.html
<html>
<body>
<br><b> $(echo $instance |jq -r '.compute.name') </b></br>
<br> $(echo $instance |jq -r '.compute.location') </br>
<br> zone: $(echo $instance |jq -r '.compute.zone') </br>
<br><b><font color="blue"> $(echo $instance |jq -r '.network.interface[0].ipv4.ipAddress[0].privateIpAddress') </font></b></br>
</body>
</html>
EOF

mkdir /var/temp
touch /var/temp/ping.txt
cat <<EOF > /var/temp/ping.txt
172.16.1.4
172.17.1.4
172.17.2.4
172.18.1.4
172.18.2.4
EOF

mkdir /var/temp
touch /var/temp/dig.txt
cat <<EOF > /var/temp/dig.txt
ifconfig.co
www.google.com
EOF

touch /usr/local/bin/pingz
chmod a+x /usr/local/bin/pingz
cat <<EOF > /usr/local/bin/pingz
fping -A -f /var/temp/ping.txt
sleep 1
while read p; do
  echo -e "dig +noall +answer \$p"
  dig +noall +answer \$p
  echo ""
  sleep 1
done < /var/temp/dig.txt
EOF
