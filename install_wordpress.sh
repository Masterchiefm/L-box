#!/bin/bash

##设置安装进展log
log="/root/log_of_install_wordpress.log"
echo date > $log


## 安装必须组件
sudo apt-get install apache2 -y
if [[  $(command -v apache2)  ]] ; then
	echo "installed apache2" >>$log
else
	echo "install apache2 failed">>$log
fi

sudo apt-get install php -y
sudo apt-get install libapache2-mod-php -y
if [[  $(command -v php)  ]] ; then
	echo "installed php" >>$log
else
	echo "install php failed">>$log
fi


sudo apt-get install mysql-server -y
if [[  $(command -v mysql)  ]] ; then
	echo "installed mysql" >>$log
else
	echo "install mysql failed">>$log
fi

sudo apt-get install php-mysql -y
sudo apt-get install phpmyadmin -y

sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
sudo service mysql restart
sudo systemctl restart apache2.service




## 下载wp
wget https://cn.wordpress.org/latest-zh_CN.zip -O /tmp/wp.zip
unzip /tmp/wp.zip -d /tmp
mv -f /tmp/wordpress/* /var/www/html
sudo chmod -R 777 /var/www/html/
sudo mv /var/www/html/index.html /var/www/html/index.html0
sudo systemctl restart apache2.service





cat << EOF >> /var/www/html/.htaccess 
php_value upload_max_filesize 128M
php_value post_max_size 128M
php_value memory_limit 256M
php_value max_execution_time 300
php_value max_input_time 300
EOF

chmod 777 -R /var/www/html
service apache2 restart
 
############
# 设置数据库#
############
echo '输入数据库名,希望将WordPress安装到的数据库名称'
read DATABASE
echo '输入数据库名,希望将WordPress安装到的数据库名称' >> $log
echo $DATABASE >> $log

echo '输入要设定的数据库用户名,您的数据库用户名。'
read USER
echo '输入要设定的数据库用户名,您的数据库用户名。'>>$log
echo $USER >> $log

echo '设定数据库密码'
read password
echo '设定数据库密码' >>$log
echo $password >> $log

# mysql输入
MYSQL=`which mysql`
$MYSQL  -u root << EOF
CREATE DATABASE $DATABASE;
CREATE USER $USER;
SET PASSWORD FOR $USER =  '$password';
#SET PASSWORD FOR $USER= PASSWORD("$password");
GRANT ALL PRIVILEGES ON *.* TO '$USER'@'%' WITH GRANT OPTION;
#GRANT ALL PRIVILEGES ON $DATABASE.* TO $USER IDENTIFIED BY "$password";
FLUSH PRIVILEGES;
EOF

cat $log
