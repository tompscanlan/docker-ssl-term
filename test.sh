#!/bin/bash
. ./common.sh

sudo sed -i '$ a\127.0.0.1 google.momentumsi.com' /etc/hosts
sudo sed -i '$ a\127.0.0.1 slashdot.momentumsi.com' /etc/hosts

add_server_confg "slashdot.momentumsi.com" "slashdot.com:80" "443"
add_server_confg "google.momentumsi.com" "google.com:80" "443"

id=`cat ./running-id`
docker kill --signal="HUP" $id


curl -k https://slashdot.momentumsi.com
cat ./logs/slashdot.momentumsi.com/access.log
echo ---------------
curl -k https://google.momentumsi.com
cat ./logs/google.momentumsi.com/access.log

sudo sed -i '/127.0.0.1 google.momentumsi.com/d' /etc/hosts
sudo sed -i '/127.0.0.1 slashdot.momentumsi.com/d' /etc/hosts
