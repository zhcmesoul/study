#!/bin/bash

localUser=$2
localPassword=ak123456
localNetServiceName=company_oracle
localTableSpace=$3
localBackupDirectoryObj=backup
localBackupDirectory=/opt/oracle/backup/
localEnvironment=company

remoteHost=120.77.2.93
remoteUser=$1
remotePassword=ak123456
remoteNetServiceName=alioracle
remoteTableSpace=$1
remoteBackupDirectoryObj=DATA_PUMP_DIR
remoteBackupDirectory=/opt/oracle/admin/orcl11g/dpdump/
remoteEnvironment=aliyun
dumpFile=${remoteEnvironment}_${remoteTableSpace}_.dmp

export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11/db_1
export PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_SID=orcl11g
export TNS_ADMIN=$ORACLE_HOME/network/admin

#调用远程脚本导出远程数据库
#exportOracleDB.sh  user localTableSpace customKey
ssh -t root@$remoteHost "sh /opt/operation/exportOracleDB.sh $remoteUser $remoteTableSpace"

#从远程主机拷贝到本地
scp root@$remoteHost:${remoteBackupDirectory}${dumpFile} $localBackupDirectory

#根据远程数据库文件导入到本地数据库
#importOracleDB.sh  remoteTableSpace remoteSchema user localTableSpace dmpFile
/opt/operation/importOracleDB.sh $remoteTableSpace $remoteTableSpace $localUser $localTableSpace $dumpFile
