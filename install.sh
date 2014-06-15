#!/bin/bash
. ./common.sh

mkdir -p ./sites-enabled
mkdir -p ./conf.d
mkdir -p ./logs

docker build -t nginx-ssl-terminator .
gen_ssl "password"
add_server_confg "somehost.example.com" "172.31.254.9:8080" "443"

