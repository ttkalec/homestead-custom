# NB This file should only be used for configuring a new box

echo "******************************************"
echo "************** ADDONS ********************"
echo "******************************************"

#echo "** XDEBUG CONFIG **"

xdebug="
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_port = 9000
xdebug.scream=0
xdebug.cli_color=1
xdebug.show_local_vars=1
"
#sudo echo "$xdebug" >> "/etc/php5/mods-available/xdebug.ini"

fastcgitimeout="
fastcgi_read_timeout 600;
"
if ! grep -q "fastcgi_read" "/etc/nginx/fastcgi_params"; then
	echo "** XDEBUG NGINX TIMEOUT CONFIG **"
	sudo echo "$fastcgitimeout" >> "/etc/nginx/fastcgi_params"
fi

echo "** INSTALLING MAILCATCHA **"
sudo apt-get install ruby1.9.1-dev -y
sudo apt-get install libsqlite3-dev
sudo gem install mailcatcher
sudo mailcatcher --ip=192.168.10.10

echo "** RESTARTING THINGS **"
service php5-fpm restart
service nginx restart