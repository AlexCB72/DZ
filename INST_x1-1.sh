#!/bin/bash
# �������� ����� ������ �� REPO
# filebeat_7.17.3_x86_64-224190-4c3205.rpm
# logstash_7.17.3_x86_64-224190-3a605f.rpm
# node_exporter-1.6.0.linux-amd64.tar.gz
# node_exporter.service


# �������� � RepoHOST ��������� ������
yum -y install sshpass rsync
SSHPASS='qazxsw'; rsync -avvuPz --delete-during -e "ssh -p 22 " --rsh="/usr/bin/sshpass -p $SSHPASS ssh -o StrictHostKeyChecking=no -l root" user@192.168.1.20:/home/user/OTUS/REPO/x1/ /home/user/OTUS/

# ��������� �� ������. ����� �������� �������� ������ � 
#���������� ���������� CUR_MOD
CUR_MOD=$(cat /etc/selinux/config | grep -v "# "| grep "SELINUX=")

# ������� ������ ������
echo "������� ��������� SELinux"
sestatus | grep -e{"SELinux status","Current mode"} 

#������ ������ �� disabled � ���������� �� ��������� ����
cat /etc/selinux/config | sed s/$CUR_MOD/"SELINUX=disabled"/  > selinuxTMP

#������ ����������������� ����� �� ����������������
mv selinuxTMP /etc/selinux/config;

# ��������� firewalld
systemctl stop firewalld
systemctl disable firewalld 

reboot










