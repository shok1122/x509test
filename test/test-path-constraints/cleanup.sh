#!/bin/sh

. ../util.sh

banner 'Cleanup Tier1'
clean_ca 'tier1.net'
echo 'DONE.'

banner 'Cleanup Tier2'
clean_ca 'tier2.net'
echo 'DONE.'

banner 'Cleanup Tier3'
clean_ca 'tier3.net'
echo 'DONE.'

banner 'Cleanup Tier4a'
clean_ca 'tier4a.net'
echo 'DONE.'

banner 'Cleanup Tier4b'
clean_ca 'tier4b.net'
echo 'DONE.'

