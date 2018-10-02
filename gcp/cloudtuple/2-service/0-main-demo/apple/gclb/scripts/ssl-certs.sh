#!/bin/bash

# https://cloud.google.com/load-balancing/docs/ssl-certificates

export DIRECTORY=~/tf/credentials/ssl/certs

#sudo apt-get install apache2 openssl

# IPV4
#============================
mkdir -p ${DIRECTORY}/prod/
mkdir -p ${DIRECTORY}/dev/

openssl genrsa -out ${DIRECTORY}/prod/prod.key 2048
openssl genrsa -out ${DIRECTORY}/dev/dev.key 2048

{
  # Country Name (2 letter code)
  echo UK
  # State or Province Name (full name)
  echo England
  # Locality Name (eg, city)
  echo London
  # Organization Name (eg, company)
  echo CloudTuple
  # Organizational Unit Name (eg, section)
  echo gclb prod app team
  # Common Name (e.g. server FQDN or YOUR name)
  echo gclb.prod.cloudtuple.com
  # Email address
  echo prod@cloudtuple.com
  # A challenge password
  echo
  # An optional company name
  echo
} | openssl req \
  -new -key ${DIRECTORY}/prod/prod.key \
  -out ${DIRECTORY}/prod/prod.csr

openssl x509 -req -days 365 \
  -in ${DIRECTORY}/prod/prod.csr \
  -signkey ${DIRECTORY}/prod/prod.key \
  -out ${DIRECTORY}/prod/prod.crt

{
  echo UK
  echo England
  echo London
  echo CloudTuple
  echo dev app team
  echo gclb.dev.cloudtuple.com
  echo dev@cloudtuple.com
  echo
  echo
} | openssl req \
  -new -key ${DIRECTORY}/dev/dev.key \
  -out ${DIRECTORY}/dev/dev.csr

openssl x509 -req -days 365 \
  -in ${DIRECTORY}/dev/dev.csr \
  -signkey ${DIRECTORY}/dev/dev.key \
  -out ${DIRECTORY}/dev/dev.crt


  # IPV6
  #============================
  mkdir -p ${DIRECTORY}/prod-v6/
  mkdir -p ${DIRECTORY}/dev-v6/

  openssl genrsa -out ${DIRECTORY}/prod-v6/prod-v6.key 2048
  openssl genrsa -out ${DIRECTORY}/dev-v6/dev-v6.key 2048

  {
    echo UK
    echo England
    echo London
    echo CloudTuple
    echo prod app team
    echo gclb6.prod.cloudtuple.com
    echo prod@cloudtuple.com
    echo
    echo
  } | openssl req \
    -new -key ${DIRECTORY}/prod-v6/prod-v6.key \
    -out ${DIRECTORY}/prod-v6/prod-v6.csr

  openssl x509 -req -days 365 \
    -in ${DIRECTORY}/prod-v6/prod-v6.csr \
    -signkey ${DIRECTORY}/prod-v6/prod-v6.key \
    -out ${DIRECTORY}/prod-v6/prod-v6.crt

  {
    echo UK
    echo England
    echo London
    echo CloudTuple
    echo dev app team
    echo gclb6.dev.cloudtuple.com
    echo dev@cloudtuple.com
    echo
    echo
  } | openssl req \
    -new -key ${DIRECTORY}/dev-v6/dev-v6.key \
    -out ${DIRECTORY}/dev-v6/dev-v6.csr

  openssl x509 -req -days 365 \
    -in ${DIRECTORY}/dev-v6/dev-v6.csr \
    -signkey ${DIRECTORY}/dev-v6/dev-v6.key \
    -out ${DIRECTORY}/dev-v6/dev-v6.crt
