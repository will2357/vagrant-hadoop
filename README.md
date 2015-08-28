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

## Example

The following instructions are to run a MapReduce job locally.

1. Format the filesystem:
    ```
    hdfs namenode -format
    ```

1. Start NameNode daemon and DataNode daemon:
    ```
    start-dfs.sh
    ```

1. Confirm that the web interface for the NameNode is available:

    [http://127.0.0.1:50070](http://127.0.0.1:50070)


1. Make the HDFS directories required to execute MapReduce jobs:
    ```
    hdfs dfs -mkdir /user
    hdfs dfs -mkdir /user/vagrant
    ```

1. Copy the input files into the distributed filesystem:
    ```
    hdfs dfs -put /usr/local/hadoop/etc/hadoop input
    ```

1. Run the provided examples:
    ```
    hadoop jar /usr/local/hadoop/share/hadoop/mapreduce/hadoop-mapreduce-examples-2.7.1.jar grep input output 'dfs[a-z.]+'
    ```

1. Examine the output files by copying the output files from the distributed filesystem to the local filesystem:
    ```
    hdfs dfs -get output local_output
    cat local_output/*
    ```
    Or view the output files on the distributed filesystem:
    ```
    hdfs dfs -cat output/*
    ```

1. When you have finished exploring, stop the NameNode daemon and the DataNode daemon:
    ```
    stop-dfs.sh
    ```

Modified from [Apache Hadoop: Setting up a Single Node Cluster](http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html).
