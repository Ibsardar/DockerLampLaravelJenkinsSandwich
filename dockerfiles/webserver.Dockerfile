FROM ubuntu:18.04
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y apache2 
# TODO: install PHP 7.3, NOT PHP 7.2. Anything lower than 7.3 is unacceptable
RUN apt-get install -y php 
RUN apt-get install -y php-dev 
RUN apt-get install -y php-mysql 
RUN apt-get install -y libapache2-mod-php 
RUN apt-get install -y php-curl 
RUN apt-get install -y php-json 
RUN apt-get install -y php-common 
RUN apt-get install -y php-mbstring 
RUN apt-get install -y composer
RUN curl -s "https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh" | /bin/bash
RUN apt-get install -y software-properties-common
RUN apt-get install -y php 7.2-phalcon
#COPY ./config/php.ini /etc/php/7.2/apache2/php.ini .........safe to ignore for now - only need it if we need to pre-set a php setting................

# set up virtual host in docker container
COPY ./config/vhost.conf /etc/apache2/sites-available/vhost.conf
#COPY ./config/apache2.conf /etc/apache2/apache2.conf .........probably will always stick to defaults for this one..............
RUN rm -rfv /etc/apache2/sites-enabled/*.conf
RUN ln -s /etc/apache2/sites-available/vhost.conf /etc/apache2/sites-enabled/vhost.conf

# TODO: set up Laravel folder permissions correctly
# see: https://stackoverflow.com/q/30639174

# run container
CMD ["apachectl","-D","FOREGROUND"]
RUN a2enmod rewrite
EXPOSE 80
EXPOSE 443