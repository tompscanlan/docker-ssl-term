# docker-ssl-term

Runs an nginx server that terminates ssl, and proxies traffic to a different host.
Used to allow single public port to securly route to internal http hosts.

## Examples
At any time you can 

	./install.sh
	./start.sh 
	 . ./common.sh
	 add_server_confg "internal-wiki.example.com" "10.10.10.18:80" "443"
	 add_server_confg "internal-bugs.example.com" "10.10.10.18:80" "443"
	 add_server_confg "intranet.example.com" "10.10.10.20:80" "443"
	 id=`cat ./running-id`
	 docker kill --signal="HUP" $id

See test.sh for a concrete example that you can run right off.

See example-config.sh for another. 

## install

	git clone git@github.com:tompscanlan/docker-ssl-term.git'
	cd docker-ssl-term
	./install.sh

Then add some configuration; see the Examples.

## control the running of the conatiner

	 ./start.sh
or

	 ./stop.sh


## Debugging

To run an interactive shell for debugging:

	 docker run -i -t -entrypoint /bin/bash   -p 443:443 -p 80:80  -v `pwd`/sites-enabled:/etc/nginx/sites-enabled -v `pwd`/logs:/var/log/nginx  -v `pwd`/conf.d:/etc/nginx/conf.d nginx-ssl-terminator
