#!/bin/bash

#localUser=yard_debug
localUser=$2
localPassword=ak123456
localNetServiceName=company_oracle
#localTableSpace=yard_debug
localTableSpace=$3
localBackupDirectoryObj=backup
localBackupDirectory=/opt/oracle/backup/

remoteHost=120.77.2.93
remoteUser=$1
remotePassword=ak123456
remoteNetServiceName=alioracle
remoteTableSpace=$1
remoteBackupDirectoryObj=DATA_PUMP_DIR
remoteBackupDirectory=/opt/oracle/admin/orcl11g/dpdump/

export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11/db_1
export PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_SID=orcl11g
export TNS_ADMIN=$ORACLE_HOME/network/admin
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export LANG=en_US.AL32UTF8

cd /opt/operation/

#调用远程脚本导出远程数据库
ssh -t root@$remoteHost "sh /opt/operation/exportOracleDB.sh $remoteUser $remotePassword $remoteTableSpace"

#从远程主机拷贝到本地
scp root@$remoteHost:${remoteBackupDirectory}${remoteTableSpace}.dmp $localBackupDirectory
chmod 666 $localBackupDirectory${remoteTableSpace}.dmp

#根据远程数据库文件导入到本地数据库
impdp $localUser/$localPassword@$localNetServiceName full=Y directory=$localBackupDirectoryObj dumpfile=$remoteTableSpace.dmp logfile=impdp_$localTableSpace.log table_exists_action=replace remap_tablespace=$remoteTableSpace:$localTableSpace remap_schema=$remoteTableSpace:$localTableSpace

