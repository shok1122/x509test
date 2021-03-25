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
    -subj "/C=JP/ST=Aichi/L=Nagoya/O=CA111/CN=ca111.com" \
    -passin pass:pass

dir=$PWD
(
    cd ../../
    openssl ca \
        -config openssl.cnf \
        -batch \
        -extensions v3_ca \
        -out $dir/$ca_dir/cacert.pem \
        -in $dir/cache/careq.pem \
        -cert $ca_dir/cacert.pem \
        -keyfile $ca_dir/private/cakey.pem \
        -passin pass:pass \
)

