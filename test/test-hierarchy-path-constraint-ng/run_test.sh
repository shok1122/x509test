#!/bin/bash

. ../util.sh

banner 'Verify Path Tier1 -> Tier1'
openssl verify \
    -CAfile tier1.net/cacert.pem \
    tier1.net/cacert.pem
if [ $? = 0 ]; then
    echo 'OK'
else
    echo 'NG'
fi

banner 'Verify Path Tier2 -> Tier1'
openssl verify \
    -CAfile tier1.net/cacert.pem \
    tier2.net/cacert.pem
if [ $? = 0 ]; then
    echo 'OK'
else
    echo 'NG'
fi

banner 'Verify Path Tier3 -> Tier2 -> Tier1'
openssl verify \
    -CAfile tier1.net/cacert.pem \
    -untrusted tier2.net/cacert.pem \
    tier3.net/cacert.pem
if [ $? = 0 ]; then
    echo 'OK'
else
    echo 'NG'
fi

banner 'Verify Path Tier4 -> Tier3 -> Tier2 -> Tier1'
openssl verify \
    -CAfile tier1.net/cacert.pem \
    -untrusted tier2.net/cacert.pem \
    -untrusted tier3.net/cacert.pem \
    tier4.net/cacert.pem
if [ $? = 0 ]; then
    echo 'OK'
else
    echo 'NG'
fi

