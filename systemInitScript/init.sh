#!/bin/bash

echo "Start to check and init system..."

#centos-7 or not, exit if not
rpm -qa centos-release | grep -q "centos-release-7" && echo "centos 7" || { echo "not centos 7"; exit 1; }
# 1.erase firewalld
echo "erase firewalld..."
systemctl stop firewalld
yum erase -y firewalld

# 2.no password and tty requeired for sudo
echo "modify /etc/sudoers..."
sed -i 's/Defaults    requiretty/#Defaults    requiretty/g' /etc/sudoers

# 3.login with key
echo "config ssh key..."
if [ ! -f "/root/.ssh/id_rsa" ]; then
	echo "ssh-keygen..."
	ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P "";
fi
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

# 4.erase network manager
echo "erase network manager..."
systemctl stop NetworkManager
yum erase -y NetworkManager

# 5.config /etc/resov.conf
echo "config /etc/resov.conf..."
grep -q "nameserver 8.8.8.8" /etc/resolv.conf && echo "nameserver 8.8.8.8 existed" || echo "nameserver 8.8.8.8" >> /etc/resolv.conf
grep -q "nameserver 114.114.114.114" /etc/resolv.conf && echo "nameserver 114.114.114.114 existed" || echo "nameserver 114.114.114.114" >> /etc/resolv.conf

# 6.erase dnsmasq
echo "erase dnsmasq..."
systemctl stop dnsmasq
yum erase -y dnsmasq
grep -q "pkill dnsmasq" /etc/rc.local && echo "" || echo "pkill dnsmasq" >> /etc/rc.local
chmod +x /etc/rc.local

# 7.remove nscd
echo "remove nscd..."
systemctl stop nscd
yum erase -y nscd.x86_64

# 8.install net-tools
echo "install net-tools..."
yum install -y net-tools

# 9.update
echo "yum update..."
yum -y update

#finish
echo "init system finished."
