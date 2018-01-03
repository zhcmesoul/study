#!/bin/bash
remoteTableSpace=$1
remoteSchema=$2

user=$3
localTableSpace=$4
dmpFile=$5

password=ak123456
netServiceName=company_oracle
backupDirectoryObj=backup
backupDirectory=/opt/oracle/backup/

export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11/db_1
export PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_SID=orcl11g
export TNS_ADMIN=$ORACLE_HOME/network/admin

if [ ! -f "${backupDirectory}/${dmpFile}" ]; then  
	echo "备份文件不存在！${backupDirectory}/${dmpFile}"
	exit 1
fi

chmod 666 $backupDirectory/$dmpFile

#impdp yard_debug/ak123456@alioracle full=Y directory=$backupDirectoryObj dumpfile=$remoteTableSpace.dmp logfile=impdp_$localTableSpace.log table_exists_action=replace remap_tablespace=$remoteTableSpace:$localTableSpace remap_schema=$remoteTableSpace:$localTableSpace cluster=N

echo "impdp $user/$password@$netServiceName full=Y directory=$backupDirectoryObj dumpfile=$dmpFile logfile=impdp_$localTableSpace.log table_exists_action=replace remap_tablespace=$remoteTableSpace:$localTableSpace remap_schema=$remoteSchema:$localTableSpace"

impdp $user/$password@$netServiceName full=Y directory=$backupDirectoryObj dumpfile=$dmpFile logfile=impdp_$localTableSpace.log table_exists_action=replace remap_tablespace=$remoteTableSpace:$localTableSpace remap_schema=$remoteSchema:$localTableSpace

exit 0

