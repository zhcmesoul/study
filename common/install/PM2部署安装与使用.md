# <center>PM2部署安装与使用

#### 1、Introducing pm2-webshell

[pm2-webshell](https://github.com/pm2-hive/pm2-webshell)是第一个值得注意的概念证明。它允许您在浏览器中直接显示完整功能的终端，可从任何地方（这是可配置的）。在引擎盖下，它使用[pty.js模块，](https://github.com/chjj/pty.js/)允许您使用伪终端文件描述符来分支进程。

您可以将pm2-webshell配置为：

- 更改用户名和密码进行认证
- 更改侦听端口
- 使用HTTPS而不是HTTP安全地将数据从浏览器传输到模块

#### 2、Installing

如果你没有[PM2](https://github.com/Unitech/pm2)安装，必须先安装它：

```shell
$ npm install pm2 -g
```

PM2是一个内置于Node.js中的进程管理器，可以深入地交互和管理应用程序。如果您计划使用它来管理Node.js软件，它还附带一个[内置的负载平衡器](https://keymetrics.io/2015/03/26/pm2-clustering-made-easy/)，以最大限度地利用资源，重新加载应用程序，而不会出现停机等等。如果您想了解有关PM2的更多信息，请参阅[官方文档](https://github.com/Unitech/pm2)和[高级文档](https://github.com/Unitech/PM2/blob/master/ADVANCED_README.md)。

一旦安装了PM2，安装pm2-webshell就是很简单的：

```shell
$ pm2 install pm2-webshell
```

这将从NPM下载pm2-webshell包，安装他的依赖关系以及一些低级库，这就是为什么你会看到一些编译命令。那么pm2将启动该模块并将其永久保持在线。

一旦模块成功安装，您将能够在进程列表中看到它：

![pm2列表与pm2-webshell](https://keymetrics.io/content/images/2015/Jun/pm2-ls.png)

卸载模块：

```shell
$ pm2 uninstall pm2-webshell
```

#### 3、Using it

在使用pm2-webshell之前，我们将配置此模块来设置其他用户名和密码。为了做到这一点，pm2使它变得容易。要配置您只需要做的模块：

```shell 
$ pm2 conf [module-name]:[configuration-variable] [new-value]
```

我们配置用户名和密码：

```shell
$ pm2 conf pm2-webshell:username myusername
$ pm2 conf pm2-webshell:password mysuperpassword
```

每次更改值时，PM2将自动重新启动目标模块。现在让我们试试吧。

默认情况下，pm2-webshell接口监听8080端口。让我们启动浏览器并连接到此页面：

```shell
$ google-chrome http://localhost:8080/
```

它现在提示您输入您之前设置的用户名和密码，填写这两个字段，您将终于可以访问该Web界面。

![浏览器控制台](https://keymetrics.io/content/images/2015/Jun/console.png)

不是很神奇吗 这个浏览器终端具有全面的功能，意味着您可以在浏览器中直接使用Emacs，Vim，Htop或任何其他高级命令。您还可以从Windows或MacOSx这个功能齐全的终端中获益！

#### 4、Securing it

如果您打算在生产服务器中使用pm2-webshell，请仔细阅读以下章节。我们建议设置一些标志。

首先，我们需要强制使用HTTPS协议而不是HTTP。该模块附带默认生成的HTTPS密钥：

```shell
$ pm2 conf pm2-webshell:https true
```

现在，而不是连接到[http：// localhost：8080 /](http://localhost:8080/)，您将需要连接到[https：// localhost：8080 /](https://localhost:8080/)。

然后更改端口：

```shell
$ pm2 conf pm2-webshell:port 1337
```

现在连接到[http：// localhost：1337 /](http://localhost:1337/)。

默认情况下，模块暴露给世界上所有人。您可以通过设置必须绑定的地址来限制此设置：

```shell
$ pm2 conf pm2-webshell:bind 127.0.0.1
```

现在只有您可以访问Web界面。

这些是确保pm2-webshell模块的基础。





<a href="/yard_doc/doc/部署文档/SPD系统初始化部署.html" style="display:block; width:35px; height:45px; border:1px solid #000; position:fixed; right:20px; bottom:20px;">回到<br/>首页</a>