## ORACLE的安装与部署、使用

### oracle的安装



下载ORACLE压缩包对其进行解压

VMWare中安装CentOS7后“ls /sbin|grep ifconfig”，没有ifconfig命令

“yum install net-tools.x86_64”安装ifconfig.

#### 步骤一：安装准备

* 安装Oracle所需的依赖包

~~~shell
yum -y install  gcc gcc-c++ make binutils compat-libstdc++-33 glibc glibc-devel libaio libaio-devel libgcc libstdc++ libstdc++-devel unixODBC unixODBC-devel sysstat ksh
~~~

* 创建用户和组

~~~sehll
groupadd -g 200 oinstall  #添加oinstall组，组的id为200

groupadd -g 201 dba       #添加dba组，组的id为201

useradd -u 440 -g oinstall -G dba oracle #添加用户oracle,并specified它的id为440.

passwd oracle             #输入oracle用户的密码

id oracle                 #查看用户id和所属组

~~~

对oracle的操作得使用oracle账号。

* 关闭SELINUX(阿里云缺省关闭)

~~~shell
vim /etc/selinux/config   #编辑配置文件,关闭SELINUX

setenforce 0              #立即关闭SELINUX
~~~

* 使用“su - u oracle”切换到oracle账号下

把下面两个文件上传到CentOS7-64bits服务器的/home/oracle目录下

~~~txt
linux.x64_11gR2_database_1of2.zip
linux.x64_11gR2_database_2of2.zip
~~~

解压缩到oracle目录下

~~~txt
unzip linux.x64_11gR2_database_1of2.zip -d /home/oracle
unzip linux.x64_11gR2_database_2of2.zip -d /home/oracle
~~~

在/home/oracle目录下会出现database目录。

* 命令配置安装参数

~~~shell
vim /home/oracle/database/response/db_install.rsp
~~~

修改后的db_install.rsp文件内容如下:

~~~shell
####################################################################
## Copyright(c) Oracle Corporation 1998,2008. All rights reserved.##
##                                                                ##
## Specify values for the variables listed below to customize     ##
## your installation.                                             ##
##                                                                ##
## Each variable is associated with a comment. The comment        ##
## can help to populate the variables with the appropriate        ##
## values.							  ##
##                                                                ##
## IMPORTANT NOTE: This file contains plain text passwords and    ##
## should be secured to have read permission only by oracle user  ##
## or db administrator who owns this installation.                ##
##                                                                ##
####################################################################

#------------------------------------------------------------------------------
# Do not change the following system generated value. 
#------------------------------------------------------------------------------
oracle.install.responseFileVersion=/oracle/install/rspfmt_dbinstall_response_schema_v11_2_0

#------------------------------------------------------------------------------
# Specify the installation option.
# It can be one of the following:
# 1. INSTALL_DB_SWONLY
# 2. INSTALL_DB_AND_CONFIG
# 3. UPGRADE_DB
#-------------------------------------------------------------------------------
oracle.install.option=INSTALL_DB_SWONLY

#-------------------------------------------------------------------------------
# Specify the hostname of the system as set during the install. It can be used
# to force the installation to use an alternative hostname rather than using the
# first hostname found on the system. (e.g., for systems with multiple hostnames 
# and network interfaces)
#-------------------------------------------------------------------------------
ORACLE_HOSTNAME=192.168.153.133

#-------------------------------------------------------------------------------
# Specify the Unix group to be set for the inventory directory.  
#-------------------------------------------------------------------------------
UNIX_GROUP_NAME=oinstall

#-------------------------------------------------------------------------------
# Specify the location which holds the inventory files.
#-------------------------------------------------------------------------------
INVENTORY_LOCATION=/opt/oraInventory

#-------------------------------------------------------------------------------
# Specify the languages in which the components will be installed.             
#
# en   : English                  ja   : Japanese                  
# fr   : French                   ko   : Korean                    
# ar   : Arabic                   es   : Latin American Spanish    
# bn   : Bengali                  lv   : Latvian                   
# pt_BR: Brazilian Portuguese     lt   : Lithuanian                
# bg   : Bulgarian                ms   : Malay                     
# fr_CA: Canadian French          es_MX: Mexican Spanish           
# ca   : Catalan                  no   : Norwegian                 
# hr   : Croatian                 pl   : Polish                    
# cs   : Czech                    pt   : Portuguese                
# da   : Danish                   ro   : Romanian                  
# nl   : Dutch                    ru   : Russian                   
# ar_EG: Egyptian                 zh_CN: Simplified Chinese        
# en_GB: English (Great Britain)  sk   : Slovak                    
# et   : Estonian                 sl   : Slovenian                 
# fi   : Finnish                  es_ES: Spanish                   
# de   : German                   sv   : Swedish                   
# el   : Greek                    th   : Thai                      
# iw   : Hebrew                   zh_TW: Traditional Chinese       
# hu   : Hungarian                tr   : Turkish                   
# is   : Icelandic                uk   : Ukrainian                 
# in   : Indonesian               vi   : Vietnamese                
# it   : Italian                                                   
#
# Example : SELECTED_LANGUAGES=en,fr,ja
#------------------------------------------------------------------------------
SELECTED_LANGUAGES=zh_CN,en

#------------------------------------------------------------------------------
# Specify the complete path of the Oracle Home.
#------------------------------------------------------------------------------
ORACLE_HOME=/opt/oracle/product/11.2.0/db_1

#------------------------------------------------------------------------------
# Specify the complete path of the Oracle Base. 
#------------------------------------------------------------------------------
ORACLE_BASE=/opt/oracle

#------------------------------------------------------------------------------
# Specify the installation edition of the component.                        
#                                                             
# The value should contain only one of these choices.        
# EE     : Enterprise Edition                                
# SE     : Standard Edition                                  
# SEONE  : Standard Edition One
# PE     : Personal Edition (WINDOWS ONLY)
#------------------------------------------------------------------------------
oracle.install.db.InstallEdition=EE

#------------------------------------------------------------------------------
# This variable is used to enable or disable custom install.
#
# true  : Components mentioned as part of 'customComponents' property
#         are considered for install.
# false : Value for 'customComponents' is not considered.
#------------------------------------------------------------------------------
oracle.install.db.isCustomInstall=false

#------------------------------------------------------------------------------
# This variable is considered only if 'IsCustomInstall' is set to true. 
#
# Description: List of Enterprise Edition Options you would like to install.
#
#              The following choices are available. You may specify any
#              combination of these choices.  The components you choose should
#              be specified in the form "internal-component-name:version"
#              Below is a list of components you may specify to install.
#        
#              oracle.rdbms.partitioning:11.2.0.1.0 - Oracle Partitioning
#              oracle.rdbms.dm:11.2.0.1.0 - Oracle Data Mining
#              oracle.rdbms.dv:11.2.0.1.0 - Oracle Database Vault 
#              oracle.rdbms.lbac:11.2.0.1.0 - Oracle Label Security
#              oracle.rdbms.rat:11.2.0.1.0 - Oracle Real Application Testing 
#              oracle.oraolap:11.2.0.1.0 - Oracle OLAP
#------------------------------------------------------------------------------
oracle.install.db.customComponents=oracle.server:11.2.0.1.0,oracle.sysman.ccr:10.2.7.0.0,oracle.xdk:11.2.0.1.0,oracle.rdbms.oci:11.2.0.1.0,oracle.network:11.2.0.1.0,oracle.network.listener:11.2.0.1.0,oracle.rdbms:11.2.0.1.0,oracle.options:11.2.0.1.0,oracle.rdbms.partitioning:11.2.0.1.0,oracle.oraolap:11.2.0.1.0,oracle.rdbms.dm:11.2.0.1.0,oracle.rdbms.dv:11.2.0.1.0,orcle.rdbms.lbac:11.2.0.1.0,oracle.rdbms.rat:11.2.0.1.0

###############################################################################
#                                                                             #
# PRIVILEGED OPERATING SYSTEM GROUPS                                  	      #
# ------------------------------------------                                  #
# Provide values for the OS groups to which OSDBA and OSOPER privileges       #
# needs to be granted. If the install is being performed as a member of the   #		
# group "dba", then that will be used unless specified otherwise below.	      #
#                                                                             #
###############################################################################

#------------------------------------------------------------------------------
# The DBA_GROUP is the OS group which is to be granted OSDBA privileges.
#------------------------------------------------------------------------------
oracle.install.db.DBA_GROUP=dba

#------------------------------------------------------------------------------
# The OPER_GROUP is the OS group which is to be granted OSOPER privileges.
#------------------------------------------------------------------------------
oracle.install.db.OPER_GROUP=oinstall

#------------------------------------------------------------------------------
# Specify the cluster node names selected during the installation.
#------------------------------------------------------------------------------
oracle.install.db.CLUSTER_NODES=

#------------------------------------------------------------------------------
# Specify the type of database to create.
# It can be one of the following:
# - GENERAL_PURPOSE/TRANSACTION_PROCESSING          
# - DATA_WAREHOUSE                                
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.type=GENERAL_PURPOSE

#------------------------------------------------------------------------------
# Specify the Starter Database Global Database Name. 
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.globalDBName=orcl

#------------------------------------------------------------------------------
# Specify the Starter Database SID.
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.SID=sidOracle11GR2

#------------------------------------------------------------------------------
# Specify the Starter Database character set.
#                                              
# It can be one of the following:
# AL32UTF8, WE8ISO8859P15, WE8MSWIN1252, EE8ISO8859P2,
# EE8MSWIN1250, NE8ISO8859P10, NEE8ISO8859P4, BLT8MSWIN1257,
# BLT8ISO8859P13, CL8ISO8859P5, CL8MSWIN1251, AR8ISO8859P6,
# AR8MSWIN1256, EL8ISO8859P7, EL8MSWIN1253, IW8ISO8859P8,
# IW8MSWIN1255, JA16EUC, JA16EUCTILDE, JA16SJIS, JA16SJISTILDE,
# KO16MSWIN949, ZHS16GBK, TH8TISASCII, ZHT32EUC, ZHT16MSWIN950,
# ZHT16HKSCS, WE8ISO8859P9, TR8MSWIN1254, VN8MSWIN1258
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.characterSet=AL32UTF8

#------------------------------------------------------------------------------
# This variable should be set to true if Automatic Memory Management 
# in Database is desired.
# If Automatic Memory Management is not desired, and memory allocation
# is to be done manually, then set it to false.
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.memoryOption=true

#------------------------------------------------------------------------------
# Specify the total memory allocation for the database. Value(in MB) should be
# at least 256 MB, and should not exceed the total physical memory available 
# on the system.
# Example: oracle.install.db.config.starterdb.memoryLimit=512
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.memoryLimit=2048

#------------------------------------------------------------------------------
# This variable controls whether to load Example Schemas onto the starter
# database or not.
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.installExampleSchemas=false

#------------------------------------------------------------------------------
# This variable includes enabling audit settings, configuring password profiles
# and revoking some grants to public. These settings are provided by default. 
# These settings may also be disabled.    
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.enableSecuritySettings=true

###############################################################################
#                                                                             #
# Passwords can be supplied for the following four schemas in the	      #
# starter database:      						      #
#   SYS                                                                       #
#   SYSTEM                                                                    #
#   SYSMAN (used by Enterprise Manager)                                       #
#   DBSNMP (used by Enterprise Manager)                                       #
#                                                                             #
# Same password can be used for all accounts (not recommended) 		      #
# or different passwords for each account can be provided (recommended)       #
#                                                                             #
###############################################################################

#------------------------------------------------------------------------------
# This variable holds the password that is to be used for all schemas in the
# starter database.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.password.ALL=我的密码

#-------------------------------------------------------------------------------
# Specify the SYS password for the starter database.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.password.SYS=

#-------------------------------------------------------------------------------
# Specify the SYSTEM password for the starter database.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.password.SYSTEM=

#-------------------------------------------------------------------------------
# Specify the SYSMAN password for the starter database.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.password.SYSMAN=

#-------------------------------------------------------------------------------
# Specify the DBSNMP password for the starter database.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.password.DBSNMP=

#-------------------------------------------------------------------------------
# Specify the management option to be selected for the starter database. 
# It can be one of the following:
# 1. GRID_CONTROL
# 2. DB_CONTROL
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.control=DB_CONTROL

#-------------------------------------------------------------------------------
# Specify the Management Service to use if Grid Control is selected to manage 
# the database.      
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.gridcontrol.gridControlServiceURL=

#-------------------------------------------------------------------------------
# This variable indicates whether to receive email notification for critical 
# alerts when using DB control.   
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.dbcontrol.enableEmailNotification=false

#-------------------------------------------------------------------------------
# Specify the email address to which the notifications are to be sent.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.dbcontrol.emailAddress=

#-------------------------------------------------------------------------------
# Specify the SMTP server used for email notifications.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.dbcontrol.SMTPServer=


###############################################################################
#                                                                             #
# SPECIFY BACKUP AND RECOVERY OPTIONS                                 	      #
# ------------------------------------		                              #
# Out-of-box backup and recovery options for the database can be mentioned    #
# using the entries below.						      #	
#                                                                             #
###############################################################################

#------------------------------------------------------------------------------
# This variable is to be set to false if automated backup is not required. Else 
# this can be set to true.
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.automatedBackup.enable=false

#------------------------------------------------------------------------------
# Regardless of the type of storage that is chosen for backup and recovery, if 
# automated backups are enabled, a job will be scheduled to run daily at
# 2:00 AM to backup the database. This job will run as the operating system 
# user that is specified in this variable.
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.automatedBackup.osuid=

#-------------------------------------------------------------------------------
# Regardless of the type of storage that is chosen for backup and recovery, if 
# automated backups are enabled, a job will be scheduled to run daily at
# 2:00 AM to backup the database. This job will run as the operating system user
# specified by the above entry. The following entry stores the password for the
# above operating system user.
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.automatedBackup.ospwd=

#-------------------------------------------------------------------------------
# Specify the type of storage to use for the database.
# It can be one of the following:
# - FILE_SYSTEM_STORAGE
# - ASM_STORAGE
#------------------------------------------------------------------------------
oracle.install.db.config.starterdb.storageType=

#-------------------------------------------------------------------------------
# Specify the database file location which is a directory for datafiles, control
# files, redo logs.         
#
# Applicable only when oracle.install.db.config.starterdb.storage=FILE_SYSTEM 
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.fileSystemStorage.dataLocation=

#-------------------------------------------------------------------------------
# Specify the backup and recovery location.
#
# Applicable only when oracle.install.db.config.starterdb.storage=FILE_SYSTEM 
#-------------------------------------------------------------------------------
oracle.install.db.config.starterdb.fileSystemStorage.recoveryLocation=

#-------------------------------------------------------------------------------
# Specify the existing ASM disk groups to be used for storage.
#
# Applicable only when oracle.install.db.config.starterdb.storage=ASM
#-------------------------------------------------------------------------------
oracle.install.db.config.asm.diskGroup=

#-------------------------------------------------------------------------------
# Specify the password for ASMSNMP user of the ASM instance.                  
#
# Applicable only when oracle.install.db.config.starterdb.storage=ASM_SYSTEM 
#-------------------------------------------------------------------------------
oracle.install.db.config.asm.ASMSNMPPassword=

#------------------------------------------------------------------------------
# Specify the My Oracle Support Account Username.
#
#  Example   : MYORACLESUPPORT_USERNAME=metalink
#------------------------------------------------------------------------------
MYORACLESUPPORT_USERNAME=

#------------------------------------------------------------------------------
# Specify the My Oracle Support Account Username password.
#
# Example    : MYORACLESUPPORT_PASSWORD=password
#------------------------------------------------------------------------------
MYORACLESUPPORT_PASSWORD=

#------------------------------------------------------------------------------
# Specify whether to enable the user to set the password for
# My Oracle Support credentials. The value can be either true or false.
# If left blank it will be assumed to be false.
#
# Example    : SECURITY_UPDATES_VIA_MYORACLESUPPORT=true
#------------------------------------------------------------------------------
SECURITY_UPDATES_VIA_MYORACLESUPPORT=

#------------------------------------------------------------------------------
# Specify whether user wants to give any proxy details for connection. 
# The value can be either true or false. If left blank it will be assumed
# to be false.
#
# Example    : DECLINE_SECURITY_UPDATES=false
#------------------------------------------------------------------------------
DECLINE_SECURITY_UPDATES=true

#------------------------------------------------------------------------------
# Specify the Proxy server name. Length should be greater than zero.
#
# Example    : PROXY_HOST=proxy.domain.com 
#------------------------------------------------------------------------------
PROXY_HOST=

#------------------------------------------------------------------------------
# Specify the proxy port number. Should be Numeric and atleast 2 chars.
#
# Example    : PROXY_PORT=25 
#------------------------------------------------------------------------------
PROXY_PORT=

#------------------------------------------------------------------------------
# Specify the proxy user name. Leave PROXY_USER and PROXY_PWD 
# blank if your proxy server requires no authentication.
#
# Example    : PROXY_USER=username 
#------------------------------------------------------------------------------
PROXY_USER=

#------------------------------------------------------------------------------
# Specify the proxy password. Leave PROXY_USER and PROXY_PWD  
# blank if your proxy server requires no authentication.
#
# Example    : PROXY_PWD=password 
#------------------------------------------------------------------------------
PROXY_PWD=
~~~



#### 步骤二：安装Oracle

* oracle账号登陆 

~~~shell
su - oracle
~~~

 在/home/oracle/database路径下执行一下命令开始安装

~~~shell
./runInstaller -silent -responseFile /home/oracle/database/response/db_install.rsp
~~~

* 出现[FATAL][INS-32012] Unable to create directory.错误提示

“chown oracle /opt”命令，修改/opt的所有者为oracle.

* 再运行以下命令开始安装

~~~shell
./runInstaller -silent -responseFile /home/oracle/database/response/db_install.rsp
~~~

出现[FATAL][INS-13013] Target environment do not meet some mandatory requirements.错误

使用下面的命令重试

~~~
/runInstaller -silent -ignorePrereq -ignoreSysPrereqs -responseFile /home/oracle/database/response/db_install.rsp
~~~

等待几分钟后出现“Successfully Setup Software.”提示。

安装好后会出现“/opt/[Oracle](http://lib.csdn.net/base/oracle)/admin/**orcl11g**/pfile”文件夹，其中“**orcl11g**”是你[oracle](http://lib.csdn.net/base/oracle)的SID，需要在环境变量中设置

否则启动listener会失败。

[2-4]按照提示以root身份登录CentOS7系统

执行下面两条命令

~~~shell
/opt/oraInventory/orainstRoot.sh
/opt/oracle/product/11.2.0/db_1/root.sh
~~~

[2-5]以oracle身份登录CentOS7系统，设置环境变量

~~~
vi ~/.bash_profile
~~~

追加下面的配置信息

~~~shell
export PATH

export ORACLE_BASE=/opt/oracle

export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1

export PATH=PATH:ORACLE_HOME/bin

export ORACLE_SID=orcl11g

export TNS_ADMIN=$ORACLE_HOME/network/admin
~~~

使用下面命令使环境变量生效

~~~shell
source ~/.bash_profile
~~~

**为了使sqlplus能够访问远程oracle数据库**，不但要配置“TNS_ADMIN”环境变量，还需要

要环境变量指向的地址（我这里是/opt/oracle/product/11.2.0/db_1/network/admin/）中放入tnsnames.ora文件

下面是我tnsnames.ora的内容，其中orcl是数据库名字。

~~~shell
alioracle =
  (DESCRIPTION =
    (ADDRESS_LIST =
      (ADDRESS = (PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1521))
    )
    (CONNECT_DATA =
      (SERVICE_NAME = orcl)
    )
  )
~~~

因为配置好了TNS，以后你也可以参考下面的命令导入数据

imp kagula/123456@alioracle  file=/home/oracle/kagula20160612.dmp full=y
kagula是用户名，123456是用户密码,alioracle是上面指定的连接名。

[2-6]建库

用oracle账号调用下面的命令

~~~shell
dbca -silent -responseFile /home/oracle/database/response/dbca.rsp
~~~

出现安装进度，需要等待几分钟。

步骤三：验证Oracle安装是否成功

[3-1]

“su - u oracle”转到oracle账户下。

sqlplus "/as sysdba"  进入SQL提示符状态

~~~sql
select * from tabs;
~~~

如果成功运行，表示oracle已经启来，否则需要运行“startup”命令启动oracle.

[3-2]

“/opt/oracle/product/11.2.0/db_1/network/admin”路径下新建listener.ora文件

内容如下

~~~shell
# copyright (c) 1997 by the Oracle Corporation
# 
# NAME
#   listener.ora
# FUNCTION
#   Network Listener startup parameter file example
# NOTES
#   This file contains all the parameters for listener.ora,
#   and could be used to configure the listener by uncommenting
#   and changing values.  Multiple listeners can be configured
#   in one listener.ora, so listener.ora parameters take the form
#   of SID_LIST_<lsnr>, where <lsnr> is the name of the listener
#   this parameter refers to.  All parameters and values are
#   case-insensitive.

# <lsnr>
#   This parameter specifies both the name of the listener, and
#   it listening address(es). Other parameters for this listener
#   us this name in place of <lsnr>.  When not specified,
#   the name for <lsnr> defaults to "LISTENER", with the default
#   address value as shown below.
#
# LISTENER =
#  (ADDRESS_LIST=
#	(ADDRESS=(PROTOCOL=tcp)(HOST=localhost)(PORT=1521))
#	(ADDRESS=(PROTOCOL=ipc)(KEY=PNPKEY)))	
LISTENER=(DESCRIPTION_LIST=(DESCRIPTION=
      (ADDRESS=(PROTOCOL=TCP)(HOST=192.168.153.133)(PORT=1521))  
  )
)

# SID_LIST_<lsnr>
#   List of services the listener knows about and can connect 
#   clients to.  There is no default.  See the Net8 Administrator's
#   Guide for more information.
#
# SID_LIST_LISTENER=
#   (SID_LIST=
#	(SID_DESC=
#			#BEQUEATH CONFIG
#          (GLOBAL_DBNAME=salesdb.mycompany)
#          (SID_NAME=sid1)			
#          (ORACLE_HOME=/private/app/oracle/product/8.0.3)
#			#PRESPAWN CONFIG
#         (PRESPAWN_MAX=20)
#	  (PRESPAWN_LIST=
#           (PRESPAWN_DESC=(PROTOCOL=tcp)(POOL_SIZE=2)(TIMEOUT=1))
#         )
#        )
#       )

SID_LIST_LISTENER=
  (SID_LIST=
      (SID_DESC=
         (GLOBAL_DBNAME=orcl)
         (SID_NAME=orcl11g)
         (ORACLE_HOME=/opt/oracle/product/11.2.0/db_1)
        (PRESPAWN_MAX=20)
        (PRESPAWN_LIST=
          (PRESPAWN_DESC=(PROTOCOL=tcp)(POOL_SIZE=2)(TIMEOUT=1))
        )
       )
      )
	
# PASSWORDS_<lsnr>
#   Specifies a password to authenticate stopping the listener.
#   Both encrypted and plain-text values can be set.  Encrypted passwords
#   can be set and stored using lsnrctl.  
#     LSNRCTL> change_password
#       Will prompt for old and new passwords, and use encryption both
#       to match the old password and to set the new one.
#     LSNRCTL> set password
#	Will prompt for the new password, for authentication with 
#       the listener. The password must be set before running the next
#       command.
#     LSNRCTL> save_config
#       Will save the changed password to listener.ora. These last two
#       steps are not necessary if SAVE_CONFIG_ON_STOP_<lsnr> is ON.
#       See below.
#
# Default: NONE
#
# PASSWORDS_LISTENER = 20A22647832FB454      # "foobar"

# SAVE_CONFIG_ON_STOP_<lsnr>
#   Tells the listener to save configuration changes to listener.ora when
#   it shuts down.  Changed parameter values will be written to the file,
#   while preserving formatting and comments.
# Default: OFF
# Values: ON/OFF
#
# SAVE_CONFIG_ON_STOP_LISTENER = ON

# USE_PLUG_AND_PLAY_<lsnr>
#   Tells the listener to contact an Onames server and register itself
#   and its services with Onames.
# Values: ON/OFF
# Default: OFF
#
# USE_PLUG_AND_PLAY_LISTENER = ON

# LOG_FILE_<lsnr>
#   Sets the name of the listener's log file.  The .log extension
#   is added automatically.
# Default=<lsnr>
#
# LOG_FILE_LISTENER = lsnr

# LOG_DIRECTORY_<lsnr>
#   Sets the directory for the listener's log file.
# Default: <oracle_home>/network/log
#
# LOG_DIRECTORY_LISTENER = /private/app/oracle/product/8.0.3/network/log

# TRACE_LEVEL_<lsnr>
#   Specifies desired tracing level.
# Default: OFF
# Values: OFF/USER/ADMIN/SUPPORT/0-16
#
# TRACE_LEVEL_LISTENER = SUPPORT

# TRACE_FILE_<lsnr>
#   Sets the name of the listener's trace file. The .trc extension
#   is added automatically.
# Default: <lsnr>
#
# TRACE_FILE_LISTENER = lsnr

# TRACE_DIRECTORY_<lsnr>
#   Sets the directory for the listener's trace file.
# Default: <oracle_home>/network/trace
#
# TRACE_DIRECTORY_LISTENER=/private/app/oracle/product/8.0.3/network/trace
# CONNECT_TIMEOUT_<lsnr>
#   Sets the number of seconds that the listener waits to get a 
#   valid database query after it has been started.
# Default: 10
#
# CONNECT_TIMEOUT_LISTENER=10
  

~~~



其中HOST中的地址要改成你CentOS7机器的IP地址,否则“lsnrctl start”命令启动侦听器，会报TNS-01189错误。

[3-3]在windows系统上测试CentOS7服务器上的Oracle是否可以链接

在Windows操作系统上下载win64_11gR2_client.zip解压缩后

admin模式下用"

setup  -ignoreSysPrereqs

"命令安装。

参考《Oracle的tnsnames.ora配置(PLSQL Developer)》

http://jingyan.baidu.com/article/b0b63dbfcd34834a4930704a.html

链接服务器，如果遇到超时错误

服务器执行“systemctl stop firewalld”临时关闭防火墙试试看。

这里奇怪的是执行“firewall-cmd --permanent --query-port=1521/tcp”命令看到端口已经开放，

后来发现得用“

**firewall-cmd  --list-all**

”命令才能真正看到端口是否开放。

## Appendix:

[1]如何安装缺少的命令

~~~shell
yum search  command-name  #查找命令所在的包
yum install package-name  #安装包
~~~









### ORACLE的导入导出

* 数据库导出：

  ~~~shell
  expdp user(用户名)/Password（密码）@SIDServiceName（SID服务名） directory=DATA_PUMP_DIR dumpfile=文件路径/oracle.dmp logfile=expdp_user.log（日志）
  ~~~

  ​

* 数据库导入：

 ~~~shell
impdp YARD_BIZ/YARD_BIZ@orcl full=Y directory=DATA_PUMP_DIR dumpfile=yard_init.dmp logfile=yard_init_log.log table_ex ists_action=replace remap_tablespace=YARD_INIT:YARD_BIZ,YARD_DEV:YARD_BIZ remap_schema=YARD_INIT:YARD_BIZ,YARD_DEV:YARD_BIZ
 ~~~



<a href="/yard_doc/doc/部署文档/SPD系统初始化部署.html" style="display:block; width:35px; height:45px; border:1px solid #000; position:fixed; right:20px; bottom:20px;">回到<br/>首页</a>