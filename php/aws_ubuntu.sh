sudo apt update -y
#sudo apt upgrade -y
sudo apt install -y apache2 apache2-utils
#systemctl status apache2
sudo systemctl start apache2
sudo systemctl enable apache2
apache2 -v
sudo chown www-data:www-data /var/www/html/ -R
sudo apt install mariadb-server mariadb-client -y
#systemctl status mariadb
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo apt install php7.2 libapache2-mod-php7.2 php7.2-mysql php-common php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-readline -y
sudo a2enmod php7.2 -y
sudo systemctl restart apache2
php --version
sudo apt install git -y
git clone https://github.com/sakiran/leave.git
sudo mysql --user="root" --password="" --execute="GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;"
sudo mysql --user="root" --password="" --execute="FLUSH PRIVILEGES;"
sudo mv leave /var/www/html/
sudo chmod -R 777 /var/www/html/
curl http://localhost/leave/php/sql.php
