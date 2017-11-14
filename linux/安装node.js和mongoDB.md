# 在阿里云服务器（centOS）安装node.js和mongoDB

登录阿里云的管理控制台，进入云服务器的实例列表中，进入你购买的云服务器，然后远程连接，进入管理终端。

第一次进入管理终端时，服务器会提示你保存一个6位的登录密码，每次连接管理终端都需要输入这个密码，请妥善保存！

进入管理终端后，就会有login输入，使用root管理员登录的话就填root，然后输入你的password，没有设置过密码的可以到实例设置里重置密码。

一般在新服务器创建后，先升级一下centOS：

```
yum -y update

```

## 2.安装gcc g++编译器

安装node.js需要通过g++进行编译，我参考的教程都没有提示先安装gcc g++，所以直接报错找不到g++命令。

其实在centOS中安装 gcc g++比较简单，直接运行命令：

```
yum install gcc-c++

```

很快就装好了。

## 3.安装node

跳转到目录：`/usr/local/src`，这个文件夹通常用来存放软件源代码：

```
cd /usr/local/src

```

下载nodejs源码，也可以使用scp命令直接上传，因为下载实在太慢了：

```
wget http://nodejs.org/dist/v6.11.0/node-v6.11.0.tar.gz

```

下载完成后解压：

```
tar -xzvf node-v6.11.0.tar.gz

```

进入解压后的文件夹：

```
cd node-v6.11.0

```

执行配置脚本来进行预编译处理：

```
./configure

```

编译源代码，这个步骤花的时间会很长：

```
make

```

编译完成后，执行安装命令，使之在系统范围内可用：

```
make install

```

安装 express 和 forever ，这两个模块都推荐 global 安装

```
npm -g install express forever

```

到这里，node.js 就基本上完成了安装过程，可以通过指令查看node及npm版本：

```
node -v

npm -v

```

## 4.安装mongoDB

直接通过官网的亚马逊镜像下载mongoDB源码非常的缓慢，几乎是没有速度的，所以通过阿里云镜像下载。

在`/etc/yum.repos.d` 创建一个mongodb-org.repo文件：

```
touch /etc/yum.repos.d/mongodb-org.repo

```

编辑mongodb-org.repo文件：

```
vi /etc/yum.repos.d/mongodb-org.repo

```

输入以下内容后，保存并退出：

```
[mogodb-org]

name=MongoDB Repository

baseurl=http://mirrors.aliyun.com/mongodb/yum/redhat/7Server/mongodb-org/3.4/x86_64/

gpgcheck=0

enabled=1

```

安装MongoDB：

```
yum install -y mongodb-org

```

启动MongoDB（这里从这里开始是mongod而不是mongodb，少了个b）：

```
service mongod start

```

设置开机启动：

```
chkconfig mongod on

```

打开MongoDB：

```
/bin/mongo
```

重启：

```
service mongod restart

```

至此，node.js和mongoDB的安装过程就结束了，还有一些关于linux和vim的学习内容，在此不便赘述，有时间再发单独的文章。下面附上我的操作结果图：
![img](https://segmentfault.com/img/bVRDPF?w=1047&h=452)