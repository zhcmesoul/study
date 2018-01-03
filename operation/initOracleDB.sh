#!/bin/bash
#该脚本用于初始化新用户的Oracle相关表空间

if [ ! -n "$1" ] ;then
	echo "命令格式 initOracleDB.sh <userName> [dbaName] [dbaPass] [oracleHome] [dataHome] [oracleName] "
    exit
fi

#参数1是新用户对应的名称
user=$1

#Oracle Dba账号密码
dbaName=sys
dbaPass=aoka2018
oracleHome=/opt/oracle/product/11/db_1
dataHome=/opt/oracle/oradata/orcl11g/
oracleName=company_oracle

if [ -n "$2" ] ;then
    dbaName=$2
fi

if [ -n "$3" ] ;then
    dbaPass=$3
fi

if [ -n "$4" ] ;then
    oracleHome=$4
fi

if [ -n "$5" ] ;then
    dataHome=$5
fi

if [ -n "$6" ] ;then
    oracleName=$6
fi


#新用户用户名和密码
spaceName=$user
password=ak123456

s="'"

echo "初始化[${spaceName}]数据"

echo "参数 dbaName[${dbaName}]  dbaPass[${dbaPass}]  oracleHome[${oracleHome}]  dataHome[${dataHome}]  oracleName[$oracleName]"

export ORACLE_HOME=$oracleHome
export NLS_LANG=AMERICAN_AMERICA.AL32UTF8
export LANG=en_US.AL32UTF8

sqlplus -S $dbaName/$dbaPass@$oracleName as sysdba <<!
drop user $spaceName cascade;
drop tablespace $spaceName including contents and datafiles;
CREATE TABLESPACE $spaceName datafile $s$dataHome$spaceName.dbf$s size 200M autoextend on next 50m maxsize unlimited;
CREATE USER $spaceName IDENTIFIED BY $password DEFAULT TABLESPACE $spaceName;
GRANT connect,resource,dba to $spaceName;
CREATE SEQUENCE $spaceName.logging_event_id_seq MINVALUE 1 START WITH 1;
exit
!
echo "初始化[${spaceName}]完成"
