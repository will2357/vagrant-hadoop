# Vagrant with Hadoop 2.7

A Vagrant virtual environment configured with Hadoop 2.7 running on Oracle Java 7.

## Installation

1. Install [VirtualBox](http://www.virtualbox.org/)
1. Install [Vagrant](http://www.vagrantup.com/downloads)
1. Run `vagrant up` (This may take a while the first time)

Confirm that the installation is working and port forwarding is correctly
configured by loading [http://127.0.0.1:4567/test.html](http://127.0.0.1:4567/test.html) in your browser.

## Use

Connect to the machine with `vagrant ssh`
Confirm that Hadoop is running on Java 7 with `hadoop version`

You should now have access to the following commands:
* `container-executor`
* `hadoop`
* `hdfs`
* `mapred`
* `rcc`
* `test-container-executor`
* `yarn`

And the following scripts:
* `distribute-exclude.sh`
* `hadoop-daemon.sh`
* `hadoop-daemons.sh`
* `hdfs-config.sh`
* `httpfs.sh`
* `kms.sh`
* `mr-jobhistory-daemon.sh`
* `refresh-namenodes.sh`
* `slaves.sh`
* `start-all.sh`
* `start-balancer.sh`
* `start-dfs.sh`
* `start-secure-dns.sh`
* `start-yarn.sh`
* `stop-all.sh`
* `stop-balancer.sh`
* `stop-dfs.sh`
* `stop-secure-dns.sh`
* `stop-yarn.sh`
* `yarn-daemon.sh`
* `yarn-daemons.sh`

Note that these and the rest of Hadoop are located in `/usr/local/hadoop`
