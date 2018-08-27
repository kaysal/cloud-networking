#!/bin/bash

# https://cloud.google.com/load-balancing/docs/ssl-certificates

sudo apt-get install apache2 openssl

mkdir -p ~/tf/ssl/certs/prod/
mkdir -p ~/tf/ssl/certs/dev/

openssl genrsa -out ~/tf/ssl/certs/dev/dev.key 2048
openssl genrsa -out ~/tf/ssl/certs/prod/prod.key 2048

openssl req \
  -new -key ~/tf/ssl/certs/dev/dev.key \
  -out ~/tf/ssl/certs/dev/dev.csr

openssl x509 -req -days 365 \
  -in ~/tf/ssl/certs/dev/dev.csr \
  -signkey ~/tf/ssl/certs/dev/dev.key \
  -out ~/tf/ssl/certs/dev/dev.crt

openssl req \
  -new -key ~/tf/ssl/certs/prod/prod.key \
  -out ~/tf/ssl/certs/prod/prod.csr

openssl x509 -req -days 365 \
  -in ~/tf/ssl/certs/prod/prod.csr \
  -signkey ~/tf/ssl/certs/prod/prod.key \
  -out ~/tf/ssl/certs/prod/prod.crt
