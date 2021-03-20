#!/bin/sh

ca_dir="materials"

rm -rf $ca_dir/*
mkdir $ca_dir/certs
mkdir $ca_dir/crl
mkdir $ca_dir/newcerts
mkdir $ca_dir/private
mkdir $ca_dir/cache
touch $ca_dir/index.txt
echo "01" > $ca_dir/serial
echo "00" > $ca_dir/crlnumber

openssl genrsa \
    -passout pass:pass \
    -aes256 \
    -out $ca_dir/private/cakey.pem \
    2048

openssl req -new \
    -key $ca_dir/private/cakey.pem \
    -out cache/careq.pem \
    -subj "/C=JP/ST=Aichi/L=Nagoya/O=CA1/CN=ca1.com" \
    -passin pass:pass \

openssl ca \
    -config ./openssl.cnf \
    -batch \
    -extensions v3_ca \
    -out $ca_dir/cacert.pem \
    -in cache/careq.pem \
    -selfsign \
    -keyfile $ca_dir/private/cakey.pem \
    -passin pass:pass \

