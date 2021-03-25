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

banner 'Cleanup Tier4'
clean_ca 'tier4.net'
echo 'DONE.'

