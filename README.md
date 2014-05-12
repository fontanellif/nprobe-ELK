# What is nProbe ElK Stak?

[nProbe™ v6 An Extensible NetFlow v5/v9/IPFIX GPL Probe for IPv4/v6](http://www.ntop.org/products/nprobe/)

[The Elasticsearch ELK Stack](http://www.elasticsearch.org/overview/)

[Keynote](/nProbe_App_for_Splunk_and_ELK.pdf "nProbe Splunk and ELK")
# Setup

The entire setup has been automated for Ubuntu. Simply run the following commands:

```
$ sudo /bin/echo -e "deb http://www.nmon.net/apt x64/\ndeb http://www.nmon.net/apt all/" > /etc/apt/sources.list.d/ntop.list
$ sudo apt-get update
$ sudo apt-get install nprobe
$ git clone https://github.com/fontanellif/nprobe-ELK.git
$ cd nprobe-ELK
$ chmod +x elk.sh
$ sudo ./elk.sh
```

Than you need to run nProbe:

```
$ nprobe -T "%IPV4_SRC_ADDR %L4_SRC_PORT %IPV4_DST_ADDR %L4_DST_PORT %PROTOCOL %IN_BYTES %OUT_BYTES %FIRST_SWITCHED %LAST_SWITCHED %HTTP_SITE %HTTP_RET_CODE %IN_PKTS %OUT_PKTS %IP_PROTOCOL_VERSION %APPLICATION_ID %L7_PROTO_NAME %ICMP_TYPE" --tcp "127.0.0.1:5556" -b 2 -i eth0 --json-labels
```
