#!/bin/bash

#Provided by Filippo Fontanelli
# This script will automatically install and configure Logstash whit embedded Elasticsearch and Kibana3

echo 'Install Pre-Reqs and EL'

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -

echo 'deb http://packages.elasticsearch.org/elasticsearch/1.0/debian stable main' >> /etc/apt/sources.list
echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' >> /etc/apt/sources.list

apt-get update
apt-get install -y --force-yes default-jdk rubygems ruby1.9.1-dev libcurl4-openssl-dev git apache2 libzmq-dev
apt-get install elasticsearch logstash
sudo update-rc.d elasticsearch defaults 95 10

echo 'Configuring Elasticsearch'
# sed -i '$a\cluster.name: elk' /etc/elasticsearch/elasticsearch.yml
# sed -i '$a\node.name: "elastic-master"' /etc/elasticsearch/elasticsearch.yml
# sed -i '$a\node.master: true' /etc/elasticsearch/elasticsearch.yml
# sed -i '$a\node.data: true' /etc/elasticsearch/elasticsearch.yml
# sed -i '$a\path.data: /var/data/elasticsearch' /etc/elasticsearch/elasticsearch.yml
# sed -i '$a\path.work: /var/data/elasticsearch/tmp' /etc/elasticsearch/elasticsearch.yml
# sed -i '$a\path.logs: /var/log/elasticsearch' /etc/elasticsearch/elasticsearch.yml

# sed -i '$a\index.number_of_shards: 1' /etc/elasticsearch/elasticsearch.yml
# sed -i '$a\index.number_of_replicas: 0' /etc/elasticsearch/elasticsearch.yml
# sed -i '$a\discovery.zen.ping.multicast.enabled: false' /etc/elasticsearch/elasticsearch.yml
# sed -i '$a\discovery.zen.ping.unicast.hosts: ["127.0.0.1:[9300-9400]"]' /etc/elasticsearch/elasticsearch.yml
# sed -i '$a\bootstrap.mlockall: true' /etc/elasticsearch/elasticsearch.yml


echo 'Create grok pattern folder'
mkdir -p /etc/logstash/patterns
cd /tmp
git clone https://github.com/logstash/logstash
cp logstash/patterns/* /etc/logstash/patterns/
rm -rf logstash
echo 'Remember to set you patterns_dir to "/etc/logstash/patterns" (i.e. patterns_dir => "/etc/logstash/patterns")'

################################ Kibana ################################

echo 'Install and configure the Kibana frontend'
cd /var/www
wget https://download.elasticsearch.org/kibana/kibana/kibana-3.0.1.tar.gz
tar zxvf kibana-*
rm kibana-*.tar.gz
mv kibana-* kibana

################################ nprobe ELK ################################
echo 'Configuring nProbe ELK'
cp logstash/conf.d/* /etc/logstash/conf.d/


echo 'Restart ELK'
service logstash restart
service elasticsearch restart

# All Done
echo "Installation has completed!!"
echo -e "Start nprobe and connect to http://localhost/kibana/index.html#/dashboard/file/logstash.json"
