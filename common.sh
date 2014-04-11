#!/bin/bash

add_server_confg() {
	mkdir -p ./logs/$1
	cat > ./sites-enabled/$1 << EOF
server {
	### server port and name ###
	listen		$3;
	server_name	$1;
	ssl		on;

	### SSL log files ###
	access_log	/var/log/nginx/$1/access.log;
	error_log	/var/log/nginx/$1/error_log;

	# move the to the http section if we're using same
	# certs across all sites.  more eff. memory wise
	### SSL cert files ###
	ssl_certificate      conf.d/ssl/momentum.in.crt;
	ssl_certificate_key  conf.d/ssl/momentum.in.key;

	### Add SSL specific settings here ###


	ssl_protocols	     SSLv3 TLSv1 TLSv1.1 TLSv1.2;
	ssl_ciphers RC4:HIGH:!aNULL:!MD5;
	ssl_prefer_server_ciphers on;
	keepalive_timeout    60;
	ssl_session_cache    shared:SSL:10m;
	ssl_session_timeout  10m;

	### We want full access to SSL via backend ###
	location / {
		proxy_pass  http://$2;

		### force timeouts if one of backend is died ##
		proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;

		### Set headers ####
		proxy_set_header	Accept-Encoding   "";
		proxy_set_header	Host		\$host;
		proxy_set_header	X-Real-IP	\$remote_addr;
		proxy_set_header	X-Forwarded-For \$proxy_add_x_forwarded_for;

		### Most PHP, Python, Rails, Java App can use this header ###
		#proxy_set_header X-Forwarded-Proto https;##
		#This is better##
		proxy_set_header	X-Forwarded-Proto \$scheme;
			add_header		Front-End-Https   on;


		### By default we don't want to redirect it ####
		# Jenkins needs this; it redirects after login
		proxy_redirect http:// https://;
	}
}
EOF
}
gen_ssl() {
	mkdir ./conf.d/ssl
	pushd ./conf.d/ssl
	openssl genrsa -des3 -passout pass:$1 -out momentum.in.key 1024
	openssl req -subj '/C=US/ST=Texas/L=Austin/CN=momentum.in' -new -key momentum.in.key -passin pass:$1 -out momentum.in.csr
	cp momentum.in.key momentum.in.key.bak
	openssl rsa -in momentum.in.key.bak -passin pass:$1 -out momentum.in.key
	openssl x509 -req -days 365 -in momentum.in.csr -signkey momentum.in.key -out momentum.in.crt
	popd
}
