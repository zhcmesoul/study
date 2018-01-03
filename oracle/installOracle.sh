#!/bin/bash
#该脚本用于安装Oracle
#需要准备安装文件 linux.x64_11gR2_database_1of2.zip linux.x64_11gR2_database_2of2.zip
#需要准备配置文件和脚本文件 git clone git@120.77.2.93:operation_script.git
#cp -rf operation_script/install/oracle/* ./
#docker run -itd -p 1525:1521 -v /opt/backup/oracle_for_linux:/oracle_install --name=server-test --hostname=docker-test1 --privileged docker.io/centos

if [ ! -n "$1" ] ;then
	echo "命令格式 installOracle.sh <服务器名称> [服务监听端口 默认1521]"
    exit
fi

#参数1 Oracle服务器IP
#oracleIp=$1

#参数2 项目缩写如:z2 zhjw
serverName=$1

#oracle监听端口 默认1521
oraclePort=1521

if [ -n "$3" ] ;then
    oraclePort=$3
fi

s="'"

echo "----开始安装oracle-----"

#echo ">>扩展 swap"
#dd if=/dev/zero of=/home/swap bs=1024 count=16400000
#mkswap /home/swap
#swapon /home/swap
#free -m

#安装oracle依赖包
yum -y install binutils compat-libcap1 compat-libstdc++-33 compat-libstdc++-33*i686 compat-libstdc++-33*.devel compat-libstdc++-33 compat-libstdc++-33*.devel gcc gcc-c++ glibc glibc*.i686 glibc-devel glibc-devel*.i686 ksh libaio libaio*.i686 libaio-devel libaio-devel*.devel libgcc libgcc*.i686 libstdc++ libstdc++*.i686 libstdc++-devel libstdc++-devel*.devel libXi libXi*.i686 libXtst libXtst*.i686 make sysstat unixODBC unixODBC*.i686 unixODBC-devel unixODBC-devel*.i686

echo ">>开始配置oracle用户和用户组"
groupadd -g 200 oinstall                 #添加oinstall组，组的id为200
groupadd -g 201 dba                      #添加dba组，组的id为201
useradd -u 440 -g oinstall -G dba oracle #添加用户oracle,并specified它的id为440.
#passwd oracle                            #输入oracle用户的密码
id oracle                                #查看用户id和所属组

echo "解压缩安装包"
mkdir /opt/oraInventory
mkdir /opt/oracle
chown -R oracle:oinstall /opt/install
chown -R oracle:oinstall /opt/oraInventory
chown -R oracle:oinstall /opt/oracle

#配置内核参数 
#cp -rf /opt/install/oracle_config/sysctl.conf /etc/sysctl.conf
#/sbin/sysctl -p

#切换用户到oracle
su - oracle <<!
cd /opt/install

unzip -o linux.x64_11gR2_database_1of2.zip
unzip -o linux.x64_11gR2_database_2of2.zip

sed -i "s/{ORACLE_IP}/${serverName}/g" /opt/install/script/oracle/oracle_config/db_install.rsp
sed -i "s/{ORACLE_IP}/${serverName}/g" /opt/install/script/oracle/oracle_config/listener.ora
sed -i "s/{ORACLE_PORT}/${oraclePort}/g" /opt/install/script/oracle/oracle_config/listener.ora
sed -i "s/{ORACLE_IP}/${serverName}/g" /opt/install/script/oracle/oracle_config/tnsnames.ora
sed -i "s/{ORACLE_PORT}/${oraclePort}/g" /opt/install/script/oracle/oracle_config/tnsnames.ora

cp -rf  /opt/install/script/oracle/oracle_config/db_install.rsp /opt/install/database/response/

/opt/install/database/runInstaller -silent -responseFile /opt/install/database/response/db_install.rsp

exit
!

echo "tail -f log文件"