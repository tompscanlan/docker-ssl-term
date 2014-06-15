docker-ssl-term
===============

docker ssl termination

## to install

> git clone git@github.com:tompscanlan/docker-ssl-term.git'
> cd docker-ssl-term
> ./install.sh

Then add some configuration; see the Examples.

## and to control the running of the conatiner:
> ./start.sh
or
> ./stop.sh

## Examples
see test.sh for a concrete example. that you can run right off.

See example-config.sh for another. Finally, at any time you can 
> . ./common.sh
> add_server_confg "slashdot.example.com" "slashdot.com:80" "443"
> id=`cat ./running-id`
> docker kill --signal="HUP" $id

## Debugging
To run an interactive shell for debugging:
> docker run -i -t -entrypoint /bin/bash   -p 443:443 -p 80:80  -v `pwd`/sites-enabled:/etc/nginx/sites-enabled -v `pwd`/logs:/var/log/nginx  -v `pwd`/conf.d:/etc/nginx/conf.d nginx-ssl-terminator
