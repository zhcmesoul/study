#!/bin/bash
#该脚本用于安装JDK

echo '开始安装JDK...';

# 开始下载JDK 安装包
cd /opt/install/

echo '开始下载JDK 安装包...';
wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz"
#获取安装包
cp -rf /opt/install/jdk-8u131-linux-x64.tar.gz /opt/
#从网上下载，一般不使用
#wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz"

#解压安装
cd /opt/
tar xzf jdk-8u131-linux-x64.tar.gz
cd /opt/jdk1.8.0_131/

alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_131/bin/jar 2
alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_131/bin/javac 2
alternatives --set jar /opt/jdk1.8.0_131/bin/jar
alternatives --set javac /opt/jdk1.8.0_131/bin/javac
alternatives --install /usr/bin/java java /opt/jdk1.8.0_131/bin/java 2

#修改系统配置
cp -rf /opt/install/script/jdk/conf/environment /etc/environment
. /etc/environment

alternatives --config java

echo 'JDK安装完成!';
echo '验证结果>>>';
echo '---------JAVA_HOME-------------';
export |grep JAVA_HOME

echo '---------environment -------------';
cat /etc/environment

echo '---------java version-------------';
java -version