#! /bin/bash

apt-get update
apt-get install -y apache2-utils

# probe script

touch /usr/local/bin/probez
chmod a+x /usr/local/bin/probez
cat <<EOF > /usr/local/bin/probez
i=0
while [ \$i -lt 2 ]; do
  ab -n 2 -c 2 http://${TARGET}/ > /dev/null 2>&1
  let i=i+1
  sleep 10
done
EOF

echo "*/8 * * * * /usr/local/bin/probez 2>&1 > /dev/null" > /tmp/crontab.txt
crontab /tmp/crontab.txt
