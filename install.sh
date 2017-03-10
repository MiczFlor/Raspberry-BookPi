#!/bin/bash

# install packages from github
sudo apt-get install postgresql php5-cli php5-gd apache2-mpm-prefork libapache2-mod-wsgi git-core python-dev python-pip libjpeg-dev libpq-dev libxml2-dev libxslt-dev rabbitmq-server redis-server tidy 

# download Booktype sources from github
cd /usr/local/
sudo mkdir src/booktype/
sudo git clone https://github.com/sourcefabric/Booktype.git --branch master --depth 1 src/booktype/

# install setup tools
sudo easy_install -U setuptools
sudo pip install -r /usr/local/src/booktype/requirements/dev.txt
sudo pip install -r /usr/local/src/booktype/requirements/prod.txt

# WEBSERVER
# prepare webserver env
sudo mkdir /var/www/booktype/
sudo chown www-data:www-data /var/www/booktype/

# DATABASE
# create database and db user
sudo -u postgres createuser -SDRP booktype-user
# now you will be prompted for a password
# then add a line to the config
echo "host booktype-db booktype-user ::1/128 md5" >> /etc/postgresql/9.4/main/pg_hba.conf