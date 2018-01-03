#!/bin/bash

localUser=yard_dev_zyf
localPassword=ak123456
localNetServiceName=company_oracle
localTableSpace=yard_dev_zyf
localBackupDirectoryObj=backup
localBackupDirectory=/opt/oracle/backup/

remoteHost=120.77.2.93
remoteUser=yard_debug
remotePassword=ak123456
remoteNetServiceName=alioracle
remoteTableSpace=yard_debug
remoteBackupDirectoryObj=DATA_PUMP_DIR
remoteBackupDirectory=/opt/oracle/admin/orcl11g/dpdump/

export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11/db_1
export PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_SID=orcl11g
export TNS_ADMIN=$ORACLE_HOME/network/admin

rm -rf $localBackupDirectory/$localTableSpace.dmp
expdp $localUser/$localPassword@$localNetServiceName directory=$localBackupDirectoryObj dumpfile=$localTableSpace.dmp logfile=expdp_$localTableSpace.log tablespaces=$localTableSpace

scp $localBackupDirectory/$localTableSpace.dmp root@$remoteHost:$remoteBackupDirectory/$localTableSpace.dmp

ssh -t root@$remoteHost "sh /opt/operation/importOracleDB.sh"
