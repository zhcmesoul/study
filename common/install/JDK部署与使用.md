<a href="/yard_doc/doc/部署文档/SPD系统初始化部署.html" style="display:block; width:35px; height:42px; border:1px solid #000; position:fixed; right:20px; bottom:20px;">回到<br/>首页</a>

本文将帮助您安装JAVA 8（JDK / JRE 8u131）或更新您的系统。从Linux命令行下载Java之前，请仔细阅读说明。要在Ubuntu和LinuxMint中安装Java 8，请阅读[本文](https://tecadmin.net/install-oracle-java-8-jdk-8-ubuntu-via-ppa/)。

## 下载最新的Java存档

#### 下载地址

> 下载前都需要进行登录操作

- linux\_x64 JDK1.8局域网[下载地址](ftp://10.1.1.74:28/soft_package/JDK/jdk-8u121-linux-x64.rpm)
- windows\_x64  JDK1.8局域网[下载地址](ftp://10.1.1.74:28/soft_package/JDK/jdk-8u66-windows-x64.exe)
- windows\_x64 JDK1.7局域网[下载地址](ftp://10.1.1.74:28/soft_package/JDK/jdk-7u51-windows-x64.exe)
- ​从其[官方下载页面](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html)下载最新的Java SE Development Kit 8版本，或者使用以下命令从shell下载。

### 对于64位

```shell
# cd /opt/
# wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz"

# tar xzf jdk-8u131-linux-x64.tar.gz
```

### 对于32位

```
# cd /opt/
# wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-i586.tar.gz"

# tar xzf jdk-8u131-linux-i586.tar.gz
```

## 用Alternatives安装Java

提取存档文件使用**替代**命令后安装它。替代命令在**chkconfig**包中可用。

```shell
# cd /opt/jdk1.8.0_131/
# alternatives --install /usr/bin/java java /opt/jdk1.8.0_131/bin/java 2
# alternatives --config java


There are 3 programs which provide 'java'.

  Selection    Command
-----------------------------------------------
*  1           /opt/jdk1.7.0_71/bin/java
 + 2           /opt/jdk1.8.0_45/bin/java
   3           /opt/jdk1.8.0_91/bin/java
   4           /opt/jdk1.8.0_131/bin/java

Enter to keep the current selection[+], or type selection number: 4

```

此时JAVA 8已成功安装在您的系统上。我们还建议使用替代方法来设置javac和jar命令路径

```shell
# alternatives --install /usr/bin/jar jar /opt/jdk1.8.0_131/bin/jar 2
# alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_131/bin/javac 2
# alternatives --set jar /opt/jdk1.8.0_131/bin/jar
# alternatives --set javac /opt/jdk1.8.0_131/bin/javac
```

## 检查已安装的Java版本

使用以下命令检查系统上安装的Java版本。

```shell
root@tecadmin ~# java -version

java version "1.8.0_131"
Java(TM) SE Runtime Environment (build 1.8.0_131-b11)
Java HotSpot(TM) 64-Bit Server VM (build 25.131-b11, mixed mode)
```

## 配置环境变量

大多数基于Java的应用程序都使用环境变量来工作。使用以下命令设置Java环境变量

- 安装**JAVA_HOME**变量
- ```
  ＃export JAVA_HOME = / opt / jdk1.8.0_131

  ```

- 设置**JRE_HOME**变量
- ```
  ＃export JRE_HOME = / opt / jdk1.8.0_131 / jre

  ```

- 设置**PATH**变量
- ```
  ＃export PATH = $ PATH：/opt/jdk1.8.0_131/bin：/opt/jdk1.8.0_131/jre/bin

  ```

还将所有上述环境变量放在**/ etc / environment**文件中，以便在系统引导时自动加载。