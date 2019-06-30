#! /bin/bash

apt-get update
apt-get install apache2 -y
a2ensite default-ssl
a2enmod ssl
HOSTNAME="$(curl -H "Metadata-Flavor:Google" \
  http://169.254.169.254/computeMetadata/v1/instance/name)"
echo "Greetings from $HOSTNAME" | tee /var/www/html/index.html
systemctl restart apache2
