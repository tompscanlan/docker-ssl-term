#!/bin/bash
. ./common.sh

mkdir -p ./sites-enabled
mkdir -p ./conf.d
mkdir -p ./logs

docker build -t nginx-ssl-terminator .
gen_ssl "password"
