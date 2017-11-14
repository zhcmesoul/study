### linux 系统启动oracle

~~~shell
# 查看监听状态
[oracle@zhouhc ~]$ lsnrctl status
# 启动监听
[oracle@zhouhc ~]$ lsnrctl start
# 停止监听
[oracle@zhouhc ~]$ lsnrctl stop
~~~







### linux系统下创建oracle表空间和用户权限查询

#### **创建用户和表空间：** 

1、登录linux，以oracle用户登录（如果是root用户登录的，登录后用 su - oracle命令切换成oracle用户）
2、以sysdba方式来打开sqlplus，命令如下： sqlplus / as sysdba
3、创建临时表空间：

```sql
--查询临时表空间文件的绝对路径。如果需要的话，可以通过查询来写定绝对路径。一般用${ORACLE_HOME}就可以了  
select name from v$tempfile;  
create temporary tablespace ZHOUHC_TEMP tempfile '${ORACLE_HOME}\oradata\ZHOUHC_TEMP.bdf' size 100m reuse autoextend on next 20m maxsize unlimited;  
```

4、创建表空间：

```sql
--查询用户表空间文件的绝对路径：
select name from v$datafile;
create tablespace ZHOUHC datafile '${ORACLE_HOME}\oradata\ZHOUHC.dbf' size 100M reuse autoextend on next 40M maxsize unlimited default storage(initial 128k next 128k minextents 2 maxextents unlimited);
```

5、创建用户和密码，指定上边创建的临时表空间和表空间

```sql
create user zhouhc identified by aoka2018 default tablespace ZHOUHC temporary tablespace ZHOUHC_TEMP;
```

6、赋予权限

```sql
grant dba to zhouhc;
grant connect,resource to zhouhc;
grant select any table to zhouhc;
grant delete any table to zhouhc;
grant update any table to zhouhc;
grant insert any table to zhouhc;
```

经过以上操作，就可以使用hc_notify/hc_password登录指定的实例，创建我们自己的表了。

 

#### **删除表空间：**

1、查看用户权限

```sql
--查看用户要具备drop tablespace的权限，如果没有,先用更高级的用户(如sys)给予授权
select a2.username,a1.privilege from dba_sys_privs a1 , user_role_privs a2
where a1.privilege = 'DROP TABLESPACE'
and a1.grantee =a2.granted_role
```

2、删除临时表空间

```sql
--查看临时表空间文件
select name from v$tempfile;
--查看用户和表空间的关系
select USERNAME,TEMPORARY_TABLESPACE from DBA_USERS;
--如果有用户的默认临时表空间是NOTIFYDB_TEMP的话，建议进行更改
alter user xxx temporary tablespace tempdefault;
---设置tempdefault为默认临时表空间
alter database default temporary tablespace tempdefault;
--删除表空间NOTIFYDB_TEMP及其包含数据对象以及数据文件
drop tablespace NOTIFYDB_TEMP including contents and datafiles; 
```

3.删除用户表空间

```sql
--查看表空间文件
select name from v$datafile;
--停止表空间的在线使用
alter tablespace 表空间名称 offline;
--删除表空间NOTIFYDB_TEMP及其包含数据对象以及数据文件
drop tablespace NOTIFYDB_TEMP including contents and datafiles; 
```

#### **Oracle用户权限查询相关操作：**

```sql
--查看所有的用户
select * from all_users;
--查看当前用户信息
select * from user_users;
--查看当前用户的角色
select * from user_role_privs;
--查看当前用户的权限
select * from user_sys_privs;
--查看当前用户的表可操作权限
select * from user_tab_privs;

--查看某一个表的约束,注意表名要 大写
select * from user_constraints where table_name='TBL_XXX';
--查看某一个表的所有索引,注意表名要 大写
select index_name,index_type,status,blevel from user_indexes where table_name = 'TBL_XXX';
--查看索引的构成,注意表名要 大写
select table_name,index_name,column_name, column_position FROM user_ind_columns WHERE table_name='TBL_XXX';

--系统数据字典 DBA_TABLESPACES 中记录了关于表空间的详细信息
select * from sys.dba_tablespaces;

--查看用户序列
select * from user_sequences;
--查看数据库序列
select * from dba_sequences;
--修改用户名密码
alter user test identified by aoka2018;
```