#!/bin/bash
#该脚本用于安装Oracle

s="'"

echo "----继续安装oracle-----"
#切换用户到oracle
su - oracle <<!

cp -rf /opt/install/script/oracle/oracle_config/tnsnames.ora /opt/oracle/product/11.2.0/db_1/network/admin/
cp -rf /opt/install/script/oracle/oracle_config/listener.ora /opt/oracle/product/11.2.0/db_1/network/admin/

exit
!
echo "安装Oracle完成"

echo "开始建立Oracle库"

su - oracle <<!
cp -rf /opt/install/script/oracle/oracle_config/oracle_bashrc ~/.bashrc
. ~/.bashrc
dbca -silent -responseFile /opt/install/database/response/dbca.rsp
aoka2018
aoka2018

exit
!

cp -rf /opt/install/script/oracle/oracle_config/root_bashrc ~/.bashrc
. ~/.bashrc

cp -rf /opt/install/script/oracle/oracle_config/oratab /etc/oratab
chown oracle:oinstall /etc/oratab
chmod 664 /etc/oratab

cat >> /etc/rc.local << EOF
su oracle -lc "/opt/oracle/product/11.2.0/db_1/bin/lsnrctl start"
su oracle -lc "/opt/oracle/product/11.2.0/db_1/bin/dbstart"
EOF

echo "建立Oracle库完成"