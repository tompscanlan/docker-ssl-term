FROM ubuntu
MAINTAINER Tom Scanlan, tscanlan@momentumsi.com

# Install Nginx.
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -y libssl1.0.0
RUN apt-get install -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Attach volumes.
VOLUME /etc/nginx/sites-enabled
VOLUME /etc/nginx/conf.d
VOLUME /var/log/nginx

# Set working directory.
WORKDIR /etc/nginx

# Expose ports.
# Add others you'd like to listen on for re-direction
#EXPOSE 80
EXPOSE 443
#EXPOSE 444

# Define default command.
ENTRYPOINT ["nginx"]
#USER nginx
