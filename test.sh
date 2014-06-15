#!/bin/bash
. ./common.sh

./install.sh
./start.sh

sudo sed -i '$ a\127.0.0.1 google.example.com' /etc/hosts
sudo sed -i '$ a\127.0.0.1 slashdot.example.com' /etc/hosts

add_server_confg "slashdot.example.com" "slashdot.com:80" "443"
add_server_confg "google.example.com" "google.com:80" "443"

id=`cat ./running-id`
docker kill --signal="HUP" $id
sleep 2

curl -ik https://slashdot.example.com
cat ./logs/slashdot.example.com/access.log
echo ---------------
curl -ik https://google.example.com
cat ./logs/google.example.com/access.log

sudo sed -i '/127.0.0.1 google.example.com/d' /etc/hosts
sudo sed -i '/127.0.0.1 slashdot.example.com/d' /etc/hosts

./stop.sh
