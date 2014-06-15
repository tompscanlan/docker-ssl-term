#!/bin/bash
# example of how to configure the server
. ./common.sh

# create the initial self-signed cert.  You can use your own, just put it
# in the right place using this as an example
gen_ssl "password"

# listen on local host:port public.example.com:443 and send that on to 72.16.16.5:8080
add_server_confg "public.example.com" "172.16.16.5:8080" "443"

# you can listen on other ports.. need to EXPOSE them in the Dockerfile.
add_server_confg "other.example.com" "172.16.16.8:80" "444"

# this reloads the instance, enabling config changes made above
id=`cat ./running-id`
docker kill --signal="HUP" $id

