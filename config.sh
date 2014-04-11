#!/bin/bash
. ./common.sh

# to be run inside of the docker 
cd /etc/nginx/
ln -s /var/log/nginx logs

gen_ssl "password"
# do this to add more hosts at any time
add_server_confg "jenkins.int.momentumsi.com" "172.31.254.9:8080" "443"
add_server_confg "wiki.int.momentumsi.com" "172.31.254.9:80" "443"
add_server_confg "redmine.int.momentumsi.com" "172.31.254.9:80" "443"
add_server_confg "hermes.int.momentumsi.com" "172.31.254.9:80" "443"
add_server_confg "havanafe.int.momentumsi.com" "172.31.254.9:80" "443"
add_server_confg "grizzlyfe.int.momentumsi.com" "172.31.254.9:80" "443"

