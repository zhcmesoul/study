# U盘安装CentOS 7.0前准备图文详解教程

记录下U盘安装[CentOS](http://www.linuxidc.com/topicnews.aspx?tid=14) 7.0安装过程，供Linux使用参考。U盘安装Linux简单又环保，推荐大家使用。

**安装前准备**：

1、CentOS 7.0 64位系统：CentOS-7.0-1406-x86_64-DVD.iso

CentOS-7.0-1406 ISO境像下载地址： [http://www.linuxidc.com/Linux/2014-07/104146.htm](http://www.linuxidc.com/Linux/2014-07/104146.htm)

2、UltraISO

软碟通UltraISO v9.5.3.2901 简体中文完美注册版 [http://www.linuxidc.com/linux/2012-11/74577.htm](http://www.linuxidc.com/linux/2012-11/74577.htm)

3、一个至少8G的U盘

然后开始动工。

**安装过程**：

1.先使用UltraISO刻录镜像至U盘内（PS:刻录的时候隐藏启动分区可以选成无，里面的packages文件夹可以删除，这个文件夹是没什么用的，而且大小挺大的，因为安装的时候有镜像在U盘内）

![U盘安装CentOS 7.0图文详解教程](http://www.linuxidc.com/upload/2014_10/14101410225958.jpg)![U盘安装CentOS 7.0图文详解教程](http://www.linuxidc.com/upload/2014_10/14101410225580.jpg)

2.再将CentOS-7.0-1406-x86_64-DVD.iso镜像拷贝到U盘内。（**这步不要忘记哈**）

3.更改bios启动顺序（即U盘先启动），然后进入此界面，按下tab键，将

![U盘安装CentOS 7.0图文详解教程](http://www.linuxidc.com/upload/2014_10/14101410221640.png)

将

vmlinuz initrd=initrd.img inst.stage2=hd:LABEL=CentOS\x207\x20x86_64 rd.live.check quiet

改为：

vmlinuz initrd=initrd.img repo=hd:/dev/sdb1:/ quiet

注：一般是sdb,因为硬盘一般是sda,可能会有不同，但是一般是sdb1..

点击回车，就OK啦。







<a href="/yard_doc/doc/部署文档/SPD系统初始化部署.html" style="display:block; width:35px; height:45px; border:1px solid #000; position:fixed; right:20px; bottom:20px;">回到<br/>首页</a>