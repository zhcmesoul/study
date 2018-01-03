#!/bin/bash

user=$1
localTableSpace=$2
password=ak123456
netServiceName=company_oracle
backupDirectoryObj=backup
backupDirectory=/opt/oracle/backup/
environment=company

#用户自定义标识
customKey=''
if [ -n "$3" ] ;then
    customKey=$3
fi

dmpFile=${environment}_${localTableSpace}_${customKey}.dmp

export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11/db_1
export PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_SID=orcl11g
export TNS_ADMIN=$ORACLE_HOME/network/admin

rm -rf $backupDirectory/${dmpFile}

expdp $user/$password@$netServiceName compression=ALL directory=${backupDirectoryObj} dumpfile=${dmpFile} logfile=expdp_$localTableSpace.log tablespaces=$localTableSpace

