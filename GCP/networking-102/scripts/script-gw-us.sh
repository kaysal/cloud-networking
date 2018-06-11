#! /bin/bash
sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
# iptables -t nat -A POSTROUTING -o eth0 -j SNAT --to-source 192.168.30.11
# iptables -A PREROUTING -t nat -i eth0 -d 192.168.30.11 -p tcp --dport 80 -j DNAT --to <faux-on-prem-svc-external-ip>:80
# 192.168.30.11 = static IP outside of any existing network's address ranges in the current project
# eth0:0 = first NIC alias
cat <<EOF >>/etc/network/interfaces
auto eth0:0
iface eth0:0 inet static
address 192.168.30.11
netmask 255.255.255.255
EOF
service networking restart
