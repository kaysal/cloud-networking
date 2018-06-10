#! /bin/bash
cat <<EOF >>/etc/profile
export http_proxy=http://nat-gw-eu:3128
export https_proxy=http://nat-gw-eu:3128
EOF
