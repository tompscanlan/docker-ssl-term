
# to build:
# docker build -t nginx-ssl-terminator .
#
# to run with bash:
#  docker run -i -t -entrypoint /bin/bash   -p 443:443 -p 80:80  -v `pwd`/sites-enabled:/etc/nginx/sites-enabled -v `pwd`/logs:/var/log/nginx  nginx-ssl-terminator
#
# to run server: 
#
# Pull base image.
FROM dockerfile/ubuntu
MAINTAINER Tom Scanlan, tscanlan@momentumsi.com

# Install Nginx.
RUN apt-get install -y software-properties-common
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf


ADD . /src
RUN cd /src/ 
# Attach volumes.
VOLUME /etc/nginx/sites-enabled
VOLUME /etc/nginx/conf.d
VOLUME /var/log/nginx

# Set working directory.
WORKDIR /etc/nginx

# Expose ports.
#EXPOSE 80
EXPOSE 443
#EXPOSE 444

# Define default command.
ENTRYPOINT ["nginx"]
#USER nginx
