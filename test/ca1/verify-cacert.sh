#!/bin/sh

openssl verify \
    -CAfile materials/cacert.pem \
    materials/cacert.pem

