#! /bin/bash

# allow processes to bind to the non-local address
# (necessary for apache/nginx in Amazon EC2)
echo 'net.ipv4.ip_nonlocal_bind = 1' >> /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

# https://docs.nginx.com/nginx/admin-guide/load-balancer/tcp-udp-load-balancer/
wget https://nginx.org/keys/nginx_signing.key
apt-key add nginx_signing.key
echo 'deb http://nginx.org/packages/debian/ xenial nginx' >> /etc/apt/sources.list
echo 'deb-src http://nginx.org/packages/debian/ xenial nginx' >> /etc/apt/sources.list
apt-get update
apt-get -y install nginx \
  lxc lxctl debootstrap bridge-utils

echo 'include /etc/nginx/tcpconf.d/*;' >> /etc/nginx/nginx.conf
#echo 'include /etc/nginx/modules-enabled/*.conf;' >> /etc/nginx/nginx.conf

# setting up nginx as a tcp loadblancer to pass TLS traffic
# to backend with no SSL termination

mkdir -p /etc/nginx/tcpconf.d
touch /etc/nginx/tcpconf.d/lb

cat <<EOF >> /etc/nginx/tcpconf.d/lb
stream {
    server {
        listen cpanel1.cloudtuple.com;
        proxy_pass 10.0.3.3:2087;
    }

    server {
        listen cpanel2.cloudtuple.com;
        proxy_pass 10.0.3.4:2087;
    }
}
EOF

service nginx start

# create lxc containers
lxc-create -t download -n cpanel1 -- --dist centos --release 7 --arch amd64
lxc-create -t download -n cpanel2 -- --dist centos --release 7 --arch amd64
lxc-start --name cpanel1
lxc-start --name cpanel2
#iptables -F

sed -i "s|\<centos.common.conf\>|fedora.common.conf|" /var/lib/lxc/cpanel1/config
sed -i "s|\<centos.common.conf\>|fedora.common.conf|" /var/lib/lxc/cpanel2/config
