#! /bin/bash
apt-get update
apt-get -y install apache2
apt install -y lxc lxctl
a2enmod proxy
a2enmod proxy_http
a2enmod proxy_balancer
a2enmod lbmethod_byrequests
systemctl restart apache2
echo `hostname` | sudo tee /var/www/html/index.html
lxc-create -t download -n tenant1 -- --dist debian --release stretch --arch amd64
lxc-create -t download -n tenant2 -- --dist debian --release stretch --arch amd64
lxc-create -t download -n tenant3 -- --dist debian --release stretch --arch amd64
lxc-start --name tenant1
lxc-start --name tenant2
lxc-start --name tenant3
