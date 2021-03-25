#!/bin/bash

set -e

. ../util.sh

banner 'Verify Path Tier4 -> Tier3 -> Tier2 -> Tier1'
openssl verify \
    -CAfile tier1.net/cacert.pem \
    -untrusted tier2.net/cacert.pem \
    -untrusted tier3.net/cacert.pem \
    tier4.net/cacert.pem
echo 'OK'

