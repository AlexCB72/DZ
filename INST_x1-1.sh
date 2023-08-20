#!/bin/bash
# получаем необх пакеты из REPO
# filebeat_7.17.3_x86_64-224190-4c3205.rpm
# logstash_7.17.3_x86_64-224190-3a605f.rpm
# node_exporter-1.6.0.linux-amd64.tar.gz
# node_exporter.service


# Забираем с RepoHOST указанные пакеты
yum -y install sshpass rsync
SSHPASS='qazxsw'; rsync -avvuPz --delete-during -e "ssh -p 22 " --rsh="/usr/bin/sshpass -p $SSHPASS ssh -o StrictHostKeyChecking=no -l root" user@192.168.1.20:/home/user/OTUS/REPO/x1/ /home/user/OTUS/

# Выделение из конфиг. файла названия текущего режима и 
#присвоение переменной CUR_MOD
CUR_MOD=$(cat /etc/selinux/config | grep -v "# "| grep "SELINUX=")

# Выводим статус службы
echo "Текущее состояние SELinux"
sestatus | grep -e{"SELinux status","Current mode"} 

#Замена режима на disabled и сохранение во временный файл
cat /etc/selinux/config | sed s/$CUR_MOD/"SELINUX=disabled"/  > selinuxTMP

#Замена сонфигурационного файла на модифицированный
mv selinuxTMP /etc/selinux/config;

# Отключаем firewalld
systemctl stop firewalld
systemctl disable firewalld 

reboot










