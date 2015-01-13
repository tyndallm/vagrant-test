#!/bin/bash
 
echo "Provisioning virtual machine..."

# Git
echo "Installing Git"
apt-get install git -y > /dev/null

# Nginx
echo "Installing Nginx"
apt-get install nginx -y > /dev/null

# Ruby
echo "Installing Ruby"
git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv

# Install ruby-build
git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build

$HOME/.rbenv/bin/rbenv install

$HOME/.rbenv/bin/rbenv install 1.9.3-p194
$HOME/.rbenv/bin/rbenv global 1.9.3-p194

#Add rbenv to PATH
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> $HOME/.profile
echo 'eval "$(rbenv init -)"' >> $HOME/.profile

#own rbenv as the vagrant user
sudo chown -Rf vagrant $HOME/.rbenv

sudo su - vagrant -c "rbenv rehash && cd /var/www/octopress/ && gem install bundler"
sudo su - vagrant -c "cd /home/vagrant/octopress/ && bundle install"

# PHP
echo "Updating PHP repository"
apt-get install python-software-properties build-essential -y > /dev/null
add-apt-repository ppa:ondrej/php5 -y > /dev/null
apt-get update > /dev/null

echo "Installing PHP"
apt-get install php5-common php5-dev php5-cli php5-fpm -y > /dev/null

echo "Installing PHP extensions"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y > /dev/null

# MySQL 
echo "Preparing MySQL"
apt-get install debconf-utils -y > /dev/null
debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"

echo "Installing MySQL"
apt-get install mysql-server -y > /dev/null

echo "Installing Node"
sudo apt-get update
sudo apt-get install -y  python g++ make
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get install -y  nodejs

# Nginx Configuration
echo "Configuring Nginx"

cp /var/www/example.com/example.com /etc/nginx/sites-available/example.com > /dev/null
cp /var/www/test.com/test.com /etc/nginx/sites-enabled/test.com > /dev/null

ln -s /etc/nginx/sites-available/example.com /etc/nginx/sites-enabled/
ln -s /etc/nginx/sites-available/test.com /etc/nginx/sites-enabled/

rm -rf /etc/nginx/sites-available/default

# Restart Nginx for the config to take effect
service nginx restart > /dev/null

echo "Finished provisioning."