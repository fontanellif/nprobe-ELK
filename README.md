# What is nProbe EKL Stak?

[nProbe™ v6 An Extensible NetFlow v5/v9/IPFIX GPL Probe for IPv4/v6](http://www.ntop.org/products/nprobe/)

[The Elasticsearch ELK Stack](http://www.elasticsearch.org/overview/)

# Setup

The entire setup has been automated for Ubuntu. Simply run the following commands:

```
$ sudo apt-get install nprobe
$ git clone https://github.com/fontanellif/nprobe-ELK.git
$ cd nprobe-ELK
$ chmod +x elk.sh
$ sudo ./elk.sh

```

To run logstash use the following command:

```
$ sudo ./logstash -h
usage: ./logstash options

This script run logstash

OPTIONS:
   -h      Show this message
   -e      Elasticsearch configuration path. Default: /etc/elasticsearch/ (optional)
   -l      Logstash configuration file. Default: /etc/logstash/logstash.conf (optional)
   -w      Active logstash web UI.
   -v      Verbose

INFO:
 In order to delete all elasticsearch index, please run this command while logstash is running: curl -XDELETE 'http://localhost:9200/'
```

Elasticsearch and logstash will be listening on their default port. Kibana will be listening on 9292 port.

# Examples
We have prepared few example of logstash configuration for different input types. You can find this examples in the examples folder.
