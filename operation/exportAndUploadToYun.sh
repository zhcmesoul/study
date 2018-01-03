#!/bin/bash

localUser=yard_debug
localPassword=ak123456
localNetServiceName=company_oracle
localTableSpace=yard_debug
localBackupDirectoryObj=backup
localBackupDirectory=/opt/oracle/backup/

export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11/db_1
export PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_SID=orcl11g
export TNS_ADMIN=$ORACLE_HOME/network/admin
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export LANG=en_US.AL32UTF8

rm -rf $localBackupDirectory${localTableSpace}.dmp

expdp $localUser/$localPassword@$localNetServiceName compression=ALL directory=${localBackupDirectoryObj} dumpfile=${localTableSpace}.dmp logfile=expdp_$localTableSpace.log tablespaces=$localTableSpace

scp $localBackupDirectory${localTableSpace}.dmp root@120.77.2.93:/opt/
