#!/bin/sh

banner()
{
    echo "+----------------------------------------------------+"
    printf "| %-50s |\n" "$@"
    echo "+----------------------------------------------------+"
}

show_result()
{
    if [ $1 = 0 ]; then
        echo '> OK'
    else
        echo '> NG'
    fi
}

prepare_ca()
{
    ca_dir="$1"
    openssl_conf="$2"

    mkdir -p $ca_dir
    cp $openssl_conf $ca_dir/openssl.cnf

    (
        cd $ca_dir

        mkdir certs
        mkdir crl
        mkdir newcerts
        mkdir private
        mkdir cache

        touch index.txt

        echo "01" > serial
        echo "00" > crlnumber
    )
}

gen_private_key()
{
    ca_dir="$1"

    (
        cd $ca_dir

        openssl genrsa \
            -passout pass:pass \
            -aes256 \
            -out private/cakey.pem \
            2048
    )
}

gen_csr()
{
    ca_dir="$1"
    subject="$2"

    (
        cd $ca_dir

        openssl req -new \
            -key private/cakey.pem \
            -out cache/careq.pem \
            -subj "$subject" \
            -passin pass:pass
    )
}

gen_top_ca()
{
    ca_dir="$1"
    ca_conf="$2"
    subject="$3"

    prepare_ca "$ca_dir" "$ca_conf"

    gen_private_key "$ca_dir"

    gen_csr "$ca_dir" "$subject"

    (
        cd $ca_dir
        openssl ca \
            -config ./openssl.cnf \
            -batch \
            -extensions v3_ca \
            -out ./cacert.pem \
            -in ./cache/careq.pem \
            -selfsign \
            -keyfile ./private/cakey.pem \
            -passin pass:pass
    )
}

gen_sub_ca()
{
    sub_ca_dir="$1"
    ca_conf="$2"
    subject="$3"
    top_ca_dir="$4"

    prepare_ca "$sub_ca_dir" "$ca_conf"

    gen_private_key "$sub_ca_dir"

    gen_csr "$sub_ca_dir" "$subject"

    work_dir=$PWD

    (
        cd $top_ca_dir
        openssl ca \
            -config ./openssl.cnf \
            -batch \
            -extensions v3_ca \
            -out $work_dir/$sub_ca_dir/cacert.pem \
            -in $work_dir/$sub_ca_dir/cache/careq.pem \
            -cert ./cacert.pem \
            -keyfile ./private/cakey.pem \
            -passin pass:pass
    )
}

clean_ca()
{
    ca_dir="$1"

    rm -rf $ca_dir
}

show_cert()
{
    openssl x509 -in "$1" -text -noout
}

if [ 'util.sh' = $(basename $0) ]; then
    case "$1" in
        show-cert ) show_cert "$2";;
    esac
fi
