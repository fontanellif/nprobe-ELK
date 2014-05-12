# What is Logstash?
Logstash is a log indexer built on top of elasticsearch. It aggregates logs from multiple sources and allows you to query them using the [Apache Lucene query parser syntax](http://lucene.apache.org/core/2_9_4/queryparsersyntax.html).

Logstash is built on elasticsearch, which allows your data to scale easily. If you run out of space, simply add a new elasticsearch node to your cluster. It's easy to scale with your data.

# How it works
Logstash has two parts, the indexer and the server. The indexer works on a specific datasource to collect logs and ship them to the server. Before shipping the logs you can do interesting things, such as mutate them, add tags, or disregard them altogether.

Adding tags to certain types of logs allows you to quickly retrieve them and keep track of trending information.


# The frontend
While not a direct part of the logstash project, Kibana works on top of logstash to give you visualization and montoring tools. Kibana also gives you the flexibility to define patterns and filters and then watch the stream for these matches as they happen in realtime.

![Alt text](/img/ntopng_kibana_dashboard.png "Ntopng kibana dashboard")
# Setup
The entire setup has been automated for Ubuntu. Simply run:

```
$ sudo ./ntopng_logstash
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
