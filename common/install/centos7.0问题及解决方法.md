<a href="/yard_doc/doc/部署文档/SPD系统初始化部署.html" style="display:block; width:35px; height:42px; border:1px solid #000; position:fixed; right:20px; bottom:20px;">回到<br/>首页</a>

### SSH远程不能链接 

查看 设备mtu 

~~~shell
[root@localhost ~]# ifconfig
eno1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1200
        inet 10.1.1.131  netmask 255.255.255.0  broadcast 10.1.1.255
        ether 08:94:ef:26:06:61  txqueuelen 1000  (Ethernet)
        RX packets 5072351  bytes 6083214044 (5.6 GiB)
        RX errors 12  dropped 0  overruns 0  frame 12
        TX packets 1286509  bytes 98647540 (94.0 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 16  

eno2: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 08:94:ef:26:06:62  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 17  

eno3: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 08:94:ef:26:06:63  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 16  

eno4: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 08:94:ef:26:06:64  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 17  

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 0  (Local Loopback)
        RX packets 2331  bytes 754239 (736.5 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 2331  bytes 754239 (736.5 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 192.168.122.1  netmask 255.255.255.0  broadcast 192.168.122.255
        ether 52:54:00:26:3e:d9  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
~~~



提示：Connection closed by xxx.xxx.xxx.xxx

修改本机mtu为1500以下

~~~shell
$ sudo ifconfig en01 mtu 1200
~~~




### 安装centos7 时找不镜像文件解决方法

以U盘安装centos 7提示找不到U盘安装镜像时，操作如下

然后开机进入之后出现
dracut:/#
输入以下
输入以下命令
dracut:/# cd dev
dracut:/# ls
接下来找到以sd开头的，有的是sdd，有的是sdb，还有的是sdc，不过貌似一般都是sdb，这里你可以看到以sdb开头的文件有两个分别是sdb和sdb1，sdb1代表的就是你的U盘了，这里是假设你看到的是sdb1,我的显示是sdb4,记住你看到的是哪个。
然后重新开机，你会看到
Install or upgrade Fedora
Troubleshooting
当选第一项的时候（默认就是）按下Tab键，下面会出现
append initrd=initrd.img root=live:CDLABEL=Fedora\x2017\x20i386 quiet
这时你把后面改为
append initrd=initrd.img repo=hd:/dev/sdb1:/ quiet
其中sdb1就代表你上一步看到的，然后点确认就OK了。



### 验证许可证信息

如果安装完成后重启发现需要选择出现r,q,c等问题，可参考以下解决方法

安装centos7的时候明明已经选择了默认的许可证信息，不知道哪里出错了，安装到最后，就会显示license information(license not accepted)的信息。解决方法如下：

1.首先会进到如下界面：

![img](http://www.linuxdiyf.com/linux/uploads/allimg/160616/2-16061616112V55.jpg)

2.输入1进入许可证信息，再输入2我接受许可协议。如图：

![img](http://www.linuxdiyf.com/linux/uploads/allimg/160616/2-160616161142244.jpg)

3.输入c继续

![img](http://www.linuxdiyf.com/linux/uploads/allimg/160616/2-160616161155361.jpg)

4.此时会出现license information(license accepted),然后输入c继续，就可以进入系统了。

![img](http://www.linuxdiyf.com/linux/uploads/allimg/160616/2-16061616120XM.jpg)





### 修改IP及网关

#### 配置文件路径

- 使用root登录
- 查看IP配置文件名（在/etc/sysconfig/network-scripts/下ifcfg-eno开头的文件）

```shell
cd /etc/sysconfig/network-scripts
ls 查看文件名
```

- vi编辑 

```
vi 
```

- 操作步骤如下
  - ip地址一样编辑在vi /etc/sysconfig/network-scripts/ifcfg-em1文件中,记得先把onboot改成yes，然后再修改ip  网关  掩码。
  - 在最后一行添加MTU=1200
  - 修改完配置文件，记得‘ ：wq! ’ 保存退出
  - 然后重启网络 /etc/init.d/network restart，service network restart 有提示ok就是成功了