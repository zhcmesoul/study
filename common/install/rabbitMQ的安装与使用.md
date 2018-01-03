网址：http://www.rabbitmq.com/download.html

erlang 网址：https://www.erlang-solutions.com/resources/download.html

下载

~~~shell
[root@loaclhost /]# wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.6.9/rabbitmq-server-3.6.9-1.el7.noarch.rpm
~~~

~~~shell
$ wget https://packages.erlang-solutions.com/erlang/esl-erlang/FLAVOUR_1_general/esl-erlang_19.3-1~centos~6_amd64.rpm
~~~

安装依赖

~~~shell
$ yum install erlang
~~~

安装rabbitMQ

~~~shell
$ yum install rabbitmq-server-3.6.9-1.el7.noarch.rpm
~~~

创建rabbitMQ用户

~~~shell
$ rabbitmqctl add_user yourName yourPass
~~~

为该用户设置默认vhost的权限

~~~shell
$ rabbitmqctl set_permissions -p / yourName ".*" ".*" ".*"
~~~

设置此用户的管理员标签（以使他能够访问管理插件）

~~~shell
$ rabbitmqctl set_user_tags yourName administrator
~~~















<a href="/yard_doc/doc/部署文档/SPD系统初始化部署.html" style="display:block; width:35px; height:45px; border:1px solid #000; position:fixed; right:20px; bottom:20px;">回到<br/>首页</a>