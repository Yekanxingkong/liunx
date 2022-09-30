#!/bin/sh
#vi /home/nginx-install.sh
#chmod +x /home/nginx-install.sh
#/home/nginx-install.sh

echo 开始执行脚本
echo '#################### wget ##################'
yum -y install wget
echo '#################### scrub ##################'
yum -y install scrub
echo '#################### nano ##################'
yum -y install nano

#创建目录
echo '#################### mkdir /home ##################'
if [ ! -d "/home" ]; then
  mkdir home
  cd /home
fi


#gcc编译器安装
echo '#################### install gcc environment ##################'
yum -y install gcc-c++

#pcre pcre-devel安装
echo '#################### install pcre pcre-devel ##################'
yum -y install pcre pcre-devel

#zlib安装
echo '#################### install zlib zlib-devel ##################'
yum -y install zlib zlib-devel

#openSSL安装
echo '#################### install openssl openssl-devel ##################'
yum -y install openssl openssl-devel


#下载nginx安装包
echo '#################### download nginx packetge ##################'
wget -P /home http://nginx.org/download/nginx-1.23.1.tar.gz

#解压
echo '#################### install nginx ##################'
cd /home
tar -zxvf nginx-1.23.1.tar.gz
cd nginx-1.23.1
 
#配置 编译 安装
./configure --prefix=/etc/nginx --with-http_ssl_module
make
make install
 
#配置环境
ln -s /etc/nginx/sbin/nginx /usr/bin/nginx

#设置开机启动
echo '#################### config auto start ##################'
echo /etc/nginx/sbin/nginx >> /etc/nginx.local
chmod -R 755 /etc/nginx.local


#php-fpm安装
#echo '#################### install php-fpm ##################'
yum install php-8.1
yum -y install php-fpm-8.1



#复写删除数据，让数据永远无法恢复
echo '#################### 清理数据 ##################'
find /home/nginx-1.23.1.tar.gz -type f | xargs shred -fuv
find /home/nginx-1.23.1 -type f | xargs shred -fuv
clear


#启动
echo '#################### start nginx ##################'
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=9000/tcp --permanent
systemctl stop firewalld
systemctl start firewalld
nginx -c /etc/nginx/conf/nginx.conf
nginx -s reload
nginx -t
nginx -v
ps -ef | grep nginx
curl -i localhost
php-fpm -v
php -v
#停止
#nginx -s stop
 
#退出
#nginx -s quit
 
#重启
#nginx -s reload
#chmod  +x nginx-install.sh 
#./nginx-install.sh


#复写磁盘所有空的数据位置
#scrub -X empty

rm -rf /home/nginx-1.23.1
#scrub -r /home/nginx-install.sh
