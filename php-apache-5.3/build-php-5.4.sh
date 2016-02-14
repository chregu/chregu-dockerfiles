#!/bin/bash
set -e
cd /root

wget -O php-5.3.29.tar.bz2 http://ch1.php.net/get/php-5.3.29.tar.bz2/from/this/mirror
tar -xjf php-5.3.29.tar.bz2
cd php-5.3.29



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

# php 5.3 on 64bit
# from https://github.com/phpbrew/phpbrew/commit/18ef766d0e013ee87ac7d86e338ebec89fbeb445
sed -i '/^BUILD_/ s/\$(CC)/\$(CXX)/g' Makefile
sed -i '/EXTRA_LIBS = /s|$| -lstdc++|' Makefile

    
make 

make install

mkdir /etc/php5/
cp ./php.ini-production /etc/php5/php.ini

pecl install ZendOpcache

cd /root
#rm -rf php-5.3.29*

rm /etc/apache2/mods-enabled/mpm_event.load
cd /etc/apache2/mods-enabled/ 
ln -s ../mods-available/mpm_prefork.load .
update-rc.d -f apache2 remove
