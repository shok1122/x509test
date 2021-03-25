#!/bin/bash

set -e

. ../util.sh

banner 'Generate Tier1'
gen_top_ca 'tier1.net' 'tier1-openssl.cnf' '/C=JP/ST=Aichi/L=Nagoya/O=Tier1 CA/CN=tier1.net'

banner 'Generate Tier2'
gen_sub_ca 'tier2.net' 'tier2-openssl.cnf' '/C=JP/ST=Aichi/L=Nagoya/O=Tier2 CA/CN=tier2.net' 'tier1.net'

banner 'Generate Tier3'
gen_sub_ca 'tier3.net' 'tier3-openssl.cnf' '/C=JP/ST=Aichi/L=Nagoya/O=Tier3 CA/CN=tier3.net' 'tier2.net'

banner 'Generate Tier4'
gen_sub_ca 'tier4.net' 'tier4-openssl.cnf' '/C=JP/ST=Aichi/L=Nagoya/O=Tier4 CA/CN=tier4.net' 'tier3.net'

