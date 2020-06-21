sudo apt update -y
#sudo apt upgrade -y
sudo apt install -y apache2
#systemctl status apache2
sudo systemctl start apache2
sudo systemctl enable apache2
apache2 -v
#sudo chown www-data:www-data /var/www/html/ -R
sudo apt install mariadb-server mariadb-client -y
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql --user="root" --password="" --execute="GRANT ALL ON *.* TO 'admin'@'localhost' IDENTIFIED BY 'adminpassword' WITH GRANT OPTION;"
sudo mysql --user="root" --password="" --execute="FLUSH PRIVILEGES;"
#sudo apt install mysql-server -y
#sudo systemctl start mysql
#sudo systemctl enable mysql
#sudo apt install mysql-client-core-5.7 -y
#sudo apt install php7.2 libapache2-mod-php7.2 php7.2-mysql php-common php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-readline -y
#sudo a2enmod php7.2 -y
sudo apt install php php-common php-mysql php-gd php-cli -y
sudo systemctl restart apache2
php --version
sudo apt install git -y
git clone https://github.com/sakiran/leave.git

sudo mv leave /var/www/html/
sudo chmod -R 777 /var/www/html/
curl http://localhost/leave/php/sql.php


#install openjdk 8

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
sudo apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main'
sudo apt-get update
sudo apt-get install zulu-8 -y


#install sonarqube

#create the sonarqube user:
sudo adduser --system --no-create-home --group --disabled-login sonarqube
sudo mkdir /opt/sonarqube
sudo apt-get install unzip
sudo mysql --user="root" --password="" --execute="GRANT ALL ON *.* TO 'sonarqube'@'localhost' IDENTIFIED BY 'sonarqubepassword' WITH GRANT OPTION;"
sudo mysql --user="root" --password="" --execute="FLUSH PRIVILEGES;"
sudo mysql --user="sonarqube" --password="sonarqubepassword" --execute="CREATE DATABASE sonarqube;";
cd /opt/sonarqube
sudo wget https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-7.5.zip
sudo unzip sonarqube-7.5.zip
sudo rm sonarqube-7.5.zip
sudo cat >/opt/sonarqube/sonarqube-7.5/conf/sonar.properties<<- "EOF"
sonar.jdbc.username=sonarqube
sonar.jdbc.password=sonarqubepassword
sonar.jdbc.url=jdbc:mysql://localhost:3306/sonarqube?useUnicode=true&characterEncoding=utf8&rewriteBatchedStatements=true&useConfigs=maxPerformance&useSSL=false
sonar.web.host=0.0.0.0
sonar.web.port=9000
EOF

sudo cat >/etc/systemd/system/sonarqube.service<<- "EOF"
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking

ExecStart=/opt/sonarqube/sonarqube-7.5/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/sonarqube-7.5/bin/linux-x86-64/sonar.sh stop

User=sonarqube
Group=sonarqube
Restart=always

[Install]
WantedBy=multi-user.target

EOF
sudo chown -R sonarqube:sonarqube /opt/sonarqube
sudo service sonarqube start
sudo systemctl enable sonarqube
sudo mkdir /opt/sonarscanner
cd /opt/sonarscanner
sudo wget https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-3.2.0.1227-linux.zip
sudo unzip sonar-scanner-cli-3.2.0.1227-linux.zip
sudo rm sonar-scanner-cli-3.2.0.1227-linux.zip
sudo cat >/opt/sonarscanner/sonar-scanner-3.2.0.1227-linux/conf/sonar-scanner.properties<<- "EOF"
sonar.host.url=http://localhost:9000
sonar.sourceEncoding=UTF-8
EOF
sudo chmod +x /opt/sonarscanner/sonar-scanner-3.2.0.1227-linux/bin/sonar-scanner
sudo chmod -R 777 /opt/sonarscanner
sudo ln -s /opt/sonarscanner/sonar-scanner-3.2.0.1227-linux/bin/sonar-scanner /usr/local/bin/sonar-scanner


cd ~
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt install jenkins -y
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo cat /var/lib/jenkins/secrets/initialAdminPassword



#modsecurity firewall enable script
sudo apt-get install libapache2-mod-security2 -y
sudo service apache2 restart
sudo apache2ctl -M | grep security
sudo cp /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
sudo sed -i 's/SecRuleEngine DetectionOnly/SecRuleEngine On/g' /etc/modsecurity/modsecurity.conf
sudo service apache2 restart
sudo mv /usr/share/modsecurity-crs /usr/share/modsecurity-crs.bk
sudo git clone https://github.com/SpiderLabs/owasp-modsecurity-crs.git /usr/share/modsecurity-crs
sudo cp /usr/share/modsecurity-crs/crs-setup.conf.example /usr/share/modsecurity-crs/crs-setup.conf
sudo cat >/etc/apache2/mods-available/security2.conf<<- "EOF"
 <IfModule security2_module>
     SecDataDir /var/cache/modsecurity
     IncludeOptional /etc/modsecurity/*.conf
     IncludeOptional "/usr/share/modsecurity-crs/*.conf
     IncludeOptional "/usr/share/modsecurity-crs/rules/*.conf
 </IfModule>
EOF
sudo systemctl restart apache2
