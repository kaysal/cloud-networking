#! /bin/bash
# Installs apache and a custom homepage
sudo su -
apt-get update
apt-get install -y apache2
cat <<EOF > /var/www/html/index.html
<html><body><h1>Server vpc-demo-instance </h1>
<p>This page was created from a simple start up script!</p>
</body></html>
EOF
