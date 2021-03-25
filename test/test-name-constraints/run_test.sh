#!/bin/bash

. ../util.sh

#PREFIX=/home/kakei/anaconda3/bin/

banner 'Verify Path Tier1 -> Tier1'
${PREFIX}openssl verify \
    -show_chain \
    -CAfile tier1.net/cacert.pem \
    tier1.net/cacert.pem
show_result $?

banner 'Verify Path Tier2 -> Tier1'
${PREFIX}openssl verify \
    -show_chain \
    -CAfile tier1.net/cacert.pem \
    tier2.net/cacert.pem
show_result $?

banner 'Verify Path Tier3 -> Tier2 -> Tier1'
${PREFIX}openssl verify \
    -show_chain \
    -CAfile tier1.net/cacert.pem \
    -untrusted tier2.net/cacert.pem \
    tier3.net/cacert.pem
show_result $?

banner 'Verify Path Tier4a -> Tier3 -> Tier2 -> Tier1'
${PREFIX}openssl verify \
    -show_chain \
    -CAfile tier1.net/cacert.pem \
    -untrusted tier2.net/cacert.pem \
    -untrusted tier3.net/cacert.pem \
    tier4a.net/cacert.pem
show_result $?

banner 'Verify Path Tier4b -> Tier3 -> Tier2 -> Tier1'
${PREFIX}openssl verify \
    -show_chain \
    -CAfile tier1.net/cacert.pem \
    -untrusted tier2.net/cacert.pem \
    -untrusted tier3.net/cacert.pem \
    tier4b.net/cacert.pem
show_result $?

