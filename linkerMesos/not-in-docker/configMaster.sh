#!/bin/bash

rpm -i /root/pakchois-0.4-10.el7.x86_64.rpm
rpm -i /root/neon-0.30.0-3.el7.x86_64.rpm
rpm -i /root/apr-1.4.8-3.el7.x86_64.rpm
rpm -i /root/apr-util-1.5.2-6.el7.x86_64.rpm
rpm -i /root/subversion-libs-1.7.14-10.el7.x86_64.rpm
rpm -i /root/subversion-1.7.14-10.el7.x86_64.rpm
rpm -i /root/cyrus-sasl-md5-2.1.26-20.el7_2.x86_64.rpm
rpm -i /root/mesos-0.28.1-2.0.20.centos701406.x86_64.rpm
rpm -i /root/tcl-8.5.13-8.el7.x86_64.rpm
rpm -i /root/expect-5.45-14.el7_1.x86_64.rpm

#generate the key and authorized_keys
mv -f /root/.ssh/id_rsa /root/.ssh/id_rsa.back
mv -f /root/.ssh/id_rsa.pub /root/.ssh/id_rsa.pub.back
ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P ""
cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys

#!/bin/bash
if [ -z "$ENNAME" ];then
    ENNAME=eth0
fi
localip=`ip addr show $ENNAME|grep "inet.*brd.*$ENNAME"|awk '{print $2}'|awk -F/ '{print $1}'`

export MESOS_IP=$localip
export MESOS_HOSTNAME=$localip

# echo paramters from environment to /etc/mesos/ /etc/mesos-master
echo $MESOS_ZK > /etc/mesos/zk
env | grep MESOS_ | grep -v MESOS_ZK | grep -v MESOS_MASTER | grep -v MESOS_LOG_DIR > mesosenvs
cat  mesosenvs | while read line
do
	mesosenv=`echo ${line} | awk -F '=' '{print $1}'`
	mesosenvvalue=`echo ${line} | awk -F '=' '{print $2}'`
	mesosparam=${mesosenv#MESOS_}
	mesosparamfile=`echo $mesosparam | tr '[A-Z]' '[a-z]'`
	echo $mesosenvvalue > /etc/mesos-master/$mesosparamfile
done



# systemctl -H 127.0.0.1
/usr/bin/expect <<-EOF
set time 30
spawn ssh root@127.0.0.1
expect {
"*yes/no" { send "yes\r" }
}
expect eof
EOF

systemctl -H 127.0.0.1 enable mesos-master
systemctl -H 127.0.0.1 start mesos-master
