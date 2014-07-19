#!/bin/bash

#Provided by Filippo Fontanelli
# This script will automatically install and configure Logstash whit embedded Elasticsearch and Kibana3
ROOT=$(cd `dirname ${BASH_SOURCE[0]}` && echo $PWD)
echo 'Install Pre-Reqs and EL'

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

wget -O - http://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add -

echo 'deb http://packages.elasticsearch.org/elasticsearch/1.0/debian stable main' >> /etc/apt/sources.list
echo 'deb http://packages.elasticsearch.org/logstash/1.4/debian stable main' >> /etc/apt/sources.list

apt-get update
apt-get install -y --force-yes rubygems ruby1.9.1-dev libcurl4-openssl-dev git apache2 libzmq-dev
ca-certificates-java elasticsearch icedtea-7-jre-jamvm java-common libavahi-client3 libavahi-common-data libavahi-common3 libcups2 libjpeg-turbo8 libjpeg8 liblcms2-2
  libnspr4 libnss3 libnss3-1d logstash openjdk-7-jre-headless tzdata-java
apt-get install elasticsearch logstash
#sudo update-rc.d elasticsearch defaults 95 10

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
cp $ROOT/logstash/conf.d/* /etc/logstash/conf.d/


echo 'Restart ELK'
echo "service logstash restart"
echo "service elasticsearch restart"
service logstash restart
service elasticsearch restart

# All Done
echo "Installation has completed!!"
echo -e 'Start nprobe:  nprobe -T "%IPV4_SRC_ADDR %L4_SRC_PORT %IPV4_DST_ADDR %L4_DST_PORT %PROTOCOL %IN_BYTES %OUT_BYTES %FIRST_SWITCHED %LAST_SWITCHED %HTTP_SITE %HTTP_RET_CODE %IN_PKTS %OUT_PKTS %IP_PROTOCOL_VERSION %APPLICATION_ID %L7_PROTO_NAME %ICMP_TYPE" --tcp "127.0.0.1:5556" -b 2 -i eth0 --json-label'
echo -e 'And then connect to http://localhost/kibana/index.html#/dashboard/file/logstash.json'
