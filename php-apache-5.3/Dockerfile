# Just a placeholder

# for PHP 5.3/5.4
#FROM phusion/baseimage:0.9.9

FROM phusion/baseimage:0.9.18

ENV HOME /root

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
RUN apt-get update && apt-get upgrade -y && apt-get clean && rm -rf /tmp/* /var/tmp/*

RUN chmod 755 /etc/container_environment
RUN chmod 644 /etc/container_environment.sh /etc/container_environment.json

ENV DEBIAN_FRONTEND noninteractive
RUN rm -f /etc/service/sshd/down
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN apt-get install -y -f nano apache2-dev apache2-mpm-prefork autoconf libicu-dev libxslt-dev libcurl4-openssl-dev libssl-dev wget ca-certificates make build-essential libmcrypt-dev && apt-get clean && rm -rf /tmp/* /var/tmp/*

ADD build-php-5.4.sh /root/build-php-5.4.sh
RUN bash /root/build-php-5.4.sh

ADD vhost.conf /etc/apache2/sites-enabled/vhost.conf

RUN useradd -m -s /bin/bash -u 1000 -m phant 

#RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/php-fpm.conf
RUN sed -i -e "s/;date\.timezone =.*/date.timezone = Europe\/Zurich/g" /etc/php5/php.ini
RUN sed -i -e "s/;date\.timezone =.*/date.timezone = Europe\/Zurich/g" /etc/php5/php.ini
RUN echo "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20090626/opcache.so" >> /etc/php5/php.ini
#RUN sed -i -e "s/user = nobody/user = user1000/g" /etc/php5/php-fpm.conf
#RUN sed -i -e "s/group = nobody/group = user1000/g" /etc/php5/php-fpm.conf
RUN rm /etc/apache2/sites-enabled/000-default.conf
#RUN echo "LoadModule php5_module        /usr/lib/apache2/modules/libphp5.so" >> /etc/apache2/mods-available/php5.load

RUN a2enmod rewrite && a2enmod php5

CMD ["/sbin/my_init"]

EXPOSE 80

RUN mkdir -p /etc/my_init.d

RUN mkdir /etc/service/apache
ADD apache.runit /etc/service/apache/run
RUN chmod a+x /etc/service/apache/run

