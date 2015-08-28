# Vagrant with Hadoop 2.7 and HBase 1.0 on Java 7

A Vagrant virtual environment configured with Hadoop 2.7 and HBase 1.0 running on Java 7 (Oracle) and Ubuntu 14.04 x64.

## Installation

1. Install [VirtualBox](http://www.virtualbox.org/)
1. Install [Vagrant](http://www.vagrantup.com/downloads)
1. Run `vagrant up` (this may take a while the first time)

Confirm that the installation is working and port forwarding is correctly
configured by loading [http://localhost:4567/test.html](http://localhost:4567/test.html) in your browser.

Connect to the machine with `vagrant ssh`, and confirm that Hadoop is running on Java 7 with `hadoop version`.

## Commands

Below are the commands that have been added to the `vagrant` user's `PATH`.

### Hadoop

You should now have access to the following commands:
* `container-executor`, `hadoop`, `hdfs`, `mapred`, `rcc`, `test-container-executor`, and `yarn`

And the following scripts:
* `distribute-exclude.sh`, `hadoop-daemon.sh`, `hadoop-daemons.sh`, `hdfs-config.sh`, `httpfs.sh`, `kms.sh`, `mr-jobhistory-daemon.sh`, `refresh-namenodes.sh`, `slaves.sh`, `start-all.sh`, `start-balancer.sh`, `start-dfs.sh`, `start-secure-dns.sh`, `start-yarn.sh`, `stop-all.sh`, `stop-balancer.sh`, `stop-dfs.sh`, `stop-secure-dns.sh`, `stop-yarn.sh`, `yarn-daemon.sh`, and `yarn-daemons.sh`

Note that these and the rest of Hadoop are located in `/usr/local/hadoop`.

### HBase

You should now have access to the `hbase` command and the following scripts:
* `draining_servers.rb`, `get-active-master.rb`, `graceful_stop.sh`, `hbase-cleanup.sh`, `hbase-common.sh`, `hbase-config.sh`, `hbase-daemon.sh`, `hbase-daemons.sh`, `hirb.rb`, `local-master-backup.sh`, `local-regionservers.sh`, `master-backup.sh`, `region_mover.rb`, `regionservers.sh`, `region_status.rb`, `rolling-restart.sh`, `shutdown_regionserver.rb`, `start-hbase.sh`, `stop-hbase.sh`, `thread-pool.rb`, and `zookeepers.sh`

Note that these and the rest of HBase are located in `/usr/local/hbase`.

## HDFS MapReduce Example

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

    [http://localhost:50070](http://localhost:50070)


1. Make the HDFS directories required to execute MapReduce jobs:
    ```
    hdfs dfs -mkdir /user
    hdfs dfs -mkdir /user/vagrant
    ```

1. Copy the input files from the local file system into the distributed filesystem:
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
    Or view all the files in the web interface:

    [http://localhost:50070/explorer.html#/user/vagrant](http://localhost:50070/explorer.html#/user/vagrant)


1. When you have finished exploring, stop the NameNode daemon and the DataNode daemon:
    ```
    stop-dfs.sh
    ```

Modified from [Apache Hadoop: Setting up a Single Node Cluster](http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html).

## HBase on HDFS Example

1. As before, format the NameNode and start HDFS:
    ```
    hdfs namenode -format
    start-dfs.sh
    ```

1. Make and chown the HDFS HBase directory:
    ```
    hdfs dfs -mkdir /hbase
    hdfs dfs -chown vagrant /hbase
    ```

1. Start HBase:
    ```
    start-hbase.sh
    ```

1. Confirm that the Master web interface is available (RegionServer is on port 16030):

    [http://localhost:16010](http://localhost:16010)


1. Enter the HBase shell:
    ```
    hbase shell
    ```

1. Check the status, then explore:
    ```
    status
    help
    ```
    Some simple examples:
    ```
    create 'test', 'cf'
    list 'test'

    put 'test', 'row1', 'cf:a', 'value1'
    put 'test', 'row2', 'cf:b', 'value2'
    put 'test', 'row3', 'cf:c', 'value3'

    scan 'test'

    get 'test', 'row1'
    ```
    When you are finished exploring:
    ```
    disable 'test'
    drop 'test'
    exit
    ```
    Then from the shell:
    ```
    stop-hbase.sh
    stop-dfs.sh
    ```

