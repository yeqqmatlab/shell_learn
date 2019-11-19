#!/usr/bin/env bash

# auto install elk scripts

clear
echo "###################################################"
echo "###           auto install elk                  ###"
echo "###           press ctrl + c to cancel          ###"
echo "###           any key to continue               ###"
echo "###################################################"
read -p
software_dir="/usr/local/software"
elasticsearch_url="https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.4.1.tar.gz"
kibana_url="https://artifacts.elastic.co/downloads/kibana/kibana-5.4.1-linux-x86_64.tar.gz"
logstash_url="https://artifacts.elastic.co/downloads/logstash/logstash-5.4.1.tar.gz"
filebeat_url="https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-5.4.1-linux-x86_64.tar.gz"
sys_version=`cat /etc/redhat-release |awk '{print $4}' |cut -d. -f1`
IP=`ip addr |grep "inet "|grep -v 127.0.0.1|awk '{print $2}'|cut -d/ -f1`
jvm_conf="/usr/local/elasticsearch/config/jvm.options"
sys_mem=`free -m|grep Mem:|awk '{print $2}'|awk '{sum+=$1} END {print sum/1024}'|cut -d. -f1`

# wget software
wget_fun(){
if[ ! -d ${software_dir} ];then
    mkdir -p ${software_dir} && cd ${software_dir}
else
    cd ${software_dir}
fi
for software in $elasticsearch_url $kibana_url $logstash_url $filebeat_url
do
    wget -c software
done
clear
}
# initial system:install java wget;set hostname;disable firewalld
init_sys(){
[ -f /etc/init.d/functions ] && ./etc/init.d/functions
[ "${sys_version}" != "7" ] && echo "Error: This Scripts Support Centos7.xx" && exit 1
[ $(id -u) != "0" ] && echo "Error: You must be root to run this script" && exit 1
sed -i "s/SELINUX=enforcing/SELINUX=disabled" /etc/seliunx/config
setenforce 0
yum install -y java-1.8.0-openjdk wget net-tools
hostnamectl set-hostname elk-server
systemctl stop firewalld
cat >>/etc/security/limits.conf<<EOF
* soft nofile 65536
* hard nofile 65536
* soft nGproc 65536
* hard nproc 65536
EOF
}

# install elasticsearch
install elasticsearch(){
cd $software
tar zxf elasticsearch-5.4.1.tar.gz
mv elasticsearch-5.4.1 /usr/local/elasticsearch
mkdir -p /usr/local/elasticsearch/data /usr/local/elasticsearch/logs
useradd elasticsearch
chown -R elasticsearch:elasticsearch /usr/local/elasticsearch
echo "vm.max_map_count = 655360" >>/etc/sysctl.conf && sysctl -p
if [ ${sys_mem} -eq 0 ];then
	sed -i "s#`grep "^-Xmx" ${jvm_conf}`#"-Xmx512m"#g" ${jvm_conf}
	sed -i "s#`grep "^-Xms" ${jvm_conf}`#"-Xms512m"#g" ${jvm_conf}
else
	sed -i "s#`grep "^-Xmx" ${jvm_conf}`#"-Xmx${sys_mem}g"#g" ${jvm_conf}
	sed -i "s#`grep "^-Xms" ${jvm_conf}`#"-Xms${sys_mem}g"#g" ${jvm_conf}
fi
cat >>/usr/local/elasticsearch/config/elasticsearch.yml<<EOF
cluster.name: my-application
node.name: elk-server
path.data: /usr/local/elasticsearch/data
path.logs: /usr/local/elasticsearch/logs
network.host: 127.0.0.1
http.port: 9200
discovery.zen.ping.unicast.hosts: ["elk-server"]
EOF
su - elasticsearch -c "nohup /usr/local/elasticsearch/bin/elasticsearch &"
}

#install logstash

#install filebeat

#install kibana

# check

# main

# run main



