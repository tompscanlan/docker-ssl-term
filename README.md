docker-ssl-term
===============

docker ssl termination

## to install

> git clone git@github.com:tompscanlan/docker-ssl-term.git


> cd docker-ssl-term
> ./install.sh

## Examples
see test.sh for a concrete example. that you can run right off.

See example-config.sh for another. Finally, at any time you can 
> . ./common.sh
> add_server_confg "slashdot.example.com" "slashdot.com:80" "443"
> id=`cat ./running-id`
> docker kill --signal="HUP" $id

