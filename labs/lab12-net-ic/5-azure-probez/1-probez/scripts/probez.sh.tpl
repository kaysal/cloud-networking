#! /bin/bash

apt-get update
apt-get install -y apache2 apache2-utils dnsutils

# probe script

touch /usr/local/bin/probez
chmod a+x /usr/local/bin/probez
cat <<EOF > /usr/local/bin/probez
i=0
while [ \$i -lt 2 ]; do
  ab -n ${NUMBER} -c ${COUNT} -H "Host: ${HOST}" ${GCLB_BROWSE} > /dev/null 2>&1
  ab -n ${NUMBER} -c ${COUNT} -H "Host: ${HOST}" ${GCLB_CART} > /dev/null 2>&1
  ab -n ${NUMBER} -c ${COUNT} -H "Host: ${HOST}" ${GCLB_CHECKOUT} > /dev/null 2>&1
  ab -n ${NUMBER} -c ${COUNT} ${GCLB_STANDARD} > /dev/null 2>&1
  ab -n ${NUMBER} -c ${COUNT} ${TCP_PROXY} > /dev/null 2>&1
  let i=i+1
  sleep 10
done
EOF

echo "*/5 * * * * /usr/local/bin/probez 2>&1 > /dev/null" > /tmp/crontab.txt
crontab /tmp/crontab.txt
