#! /bin/bash
apt-get update
apt-get install apache2 -y
echo `hostname` | sudo tee /var/www/html/index.html
