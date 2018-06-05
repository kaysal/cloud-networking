#! /bin/bash
sudo apt-get update
sudo apt-get install apache2 -y
echo `hostname` | sudo tee /var/www/html/index.html
