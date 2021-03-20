#!/bin/sh

openssl verify \
    -CAfile ../../../../materials/cacert.pem \
    -untrusted ../../materials/cacert.pem \
    materials/cacert.pem

