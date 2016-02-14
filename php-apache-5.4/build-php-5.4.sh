#!/bin/bash

cd /root

wget -O php-5.4.45.tar.bz2 http://ch1.php.net/get/php-5.4.45.tar.bz2/from/this/mirror
tar -xjf php-5.4.45.tar.bz2
cd php-5.4.45
./configure --prefix=/usr/local \
    --enable-bcmath \
    --with-curl \
    --with-zlib \
    --enable-mbstring \
    --with-openssl \
    --with-mysqli \
    --with-mysql \
    --with-pdo-mysql \
    --with-apxs2 \
    --with-config-file-path=/etc/php5 \
    --enable-intl
    
make 

make install

mkdir /etc/php5/
cp ./php.ini-production /etc/php5/php.ini

pecl install ZendOpcache

cd /root
rm -rf php-5.4.45*

rm /etc/apache2/mods-enabled/mpm_event.load
cd /etc/apache2/mods-enabled/ 
ln -s ../mods-available/mpm_prefork.load .
update-rc.d -f apache2 remove