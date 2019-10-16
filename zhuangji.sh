#!/bin/bash
#配置yum源
#rm -rf /etc/yum.repos.d/*
#echo -e "
#[base]
#name=CentOS-releasever-Base
#baseurl=http://mirrors.tuna.tsinghua.edu.cn/centos/\$releasever/os/\$basearch/
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7
#" >/etc/yum.repos.d/CentOS-Base.repo
#yum clean all
#yum repolist
#echo -e "
#[epel]
#name=epel-el7-aliyun
#baseurl=https://mirrors.aliyun.com/epel/7/x86_64/
#enabled=1
#gpgcheck=1
#gpgkey=https://mirrors.aliyun.com/epel/RPM-GPG-KEY-EPEL-7
#" >/etc/yum.repos.d/epel.repo
#yum clean all
#yum repolist
#
#安装基础软件
yum install vim -y
echo "set tabstop=4" >>/etc/vimrc
export EDITOR vim
yum install bash-completion -y

#关闭防火墙selinux
isystemctl stop firewalld
systemctl disable firewalld

setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

#配置网络文件
read -p "请输入你的ip：192.168.85." ip
read -p "请输入你的主机名:" zhuji

echo $zhuji >/etc/hostname
hostname $zhuji
echo -e "
TYPE=\"Ethernet\"
BOOTPROTO=\"static\"
DEVICE=\"ens33\"
ONBOOT=\"yes\"
IPADDR=\"192.168.85.$ip\"
GATEWAY=\"192.168.85.2\"
DNS1=\"114.114.114.114\"
NETMASK=\"255.255.255.0\"
" > /etc/sysconfig/network-scripts/ifcfg-ens33
ifdown ens33;ifup ens33
reboot
