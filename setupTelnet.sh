#!/bin/sh

#需要安装 xinetd、telnet、telnet-server 按顺序安装
#安装顺序：xinetd--》telnet--》telnet-server

#先检测是否这些软件包是否已经安装
#rpm -qa | grep xinetd
#rpm -qa | grep telnet
#rpm -qa | grep telnet-server

rpm -ivh xinetd-2.3.15-14.el7.x86_64.rpm

rpm -ivh telnet-0.17-66.el7.x86_64.rpm

rpm -ivh telnet-server-0.17-66.el7.x86_64.rpm


#将文件中 disable = yes 修改为 disable = no
echo 'service telnet
{
flags = REUSE
socket_type = stream
wait = no
user = root
server =/usr/sbin/in.telnetd
log_on_failure += USERID
disable = no
}' > /etc/xinetd.d/telnet

#执行如下命令启动 telnet 依赖的 xinetd 服务
service xinetd restart
systemctl restart xinetd.service