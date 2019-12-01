FROM nimmis/ubuntu:18.04

MAINTAINER mrxder <info@matthias-keim.com>

##### APACHE #######

# disable interactive functions
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
apt-get install -y apache2  && \
rm -rf /var/lib/apt/lists/* && \
echo "ServerName localhost" >> /etc/apache2/apache2.conf

EXPOSE 80

###### PHP #########

RUN apt-get update && \
apt-get install -y php libapache2-mod-php  \
php-fpm php-cli php-mysqlnd php-pgsql php-sqlite3 php-redis \
php-apcu php-intl php-imagick php-json php-gd php-curl && \
rm -rf /var/lib/apt/lists/* && \
cd /tmp && curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer && \
sed -i "s/display_errors\ =\ Off/display_errors\ =\ On/" /etc/php/7.2/apache2/php.ini

####### MYSQL #########

WORKDIR /root

RUN apt-get update && \
apt-get -y install mariadb-server
RUN sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
COPY init.sql .
COPY rc.local /etc
RUN chmod +x /etc/rc.local
RUN /etc/init.d/mysql start && mysql -u root < init.sql


#### PHP MY ADMIN #####

RUN chmod +x .
RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.2/phpMyAdmin-4.9.2-all-languages.zip
RUN unzip phpMyAdmin-4.9.2-all-languages.zip
RUN chown -R www-data:www-data phpMyAdmin-4.9.2-all-languages

COPY 000-default.conf /etc/apache2/sites-enabled/
RUN /etc/init.d/apache2 restart