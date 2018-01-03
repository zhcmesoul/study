#!/bin/bash

localUser=$1
localTableSpace=$2

localPassword=ak123456
localNetServiceName=company_oracle
localBackupDirectoryObj=backup
localBackupDirectory=/opt/oracle/backup/

export ORACLE_BASE=/opt/oracle
export ORACLE_HOME=$ORACLE_BASE/product/11/db_1
export PATH=$PATH:$ORACLE_HOME/bin
export ORACLE_SID=orcl11g
export TNS_ADMIN=$ORACLE_HOME/network/admin
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export LANG=en_US.AL32UTF8

rm -rf $localBackupDirectory${localTableSpace}_test.dmp

expdp $localUser/$localPassword@$localNetServiceName compression=ALL directory=${localBackupDirectoryObj} dumpfile=${localTableSpace}_test.dmp logfile=expdp_$localTableSpace.log tablespaces=$localTableSpace

