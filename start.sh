#!/bin/bash
. ./common.sh

id=$(docker run -d -p 443:443 -v `pwd`/sites-enabled:/etc/nginx/sites-enabled -v `pwd`/logs:/var/log/nginx  -v `pwd`/conf.d:/etc/nginx/conf.d nginx-ssl-terminator)
echo $id > ./running-id

# to run an interactive shell
#docker run -i -t -entrypoint /bin/bash   -p 443:443 -p 80:80  -v `pwd`/sites-enabled:/etc/nginx/sites-enabled -v `pwd`/logs:/var/log/nginx  -v `pwd`/conf.d:/etc/nginx/conf.d nginx-ssl-terminator
