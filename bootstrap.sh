#!/usr/bin/env bash
JAVA_HOME_DIR=/usr/lib/jvm/java-7-oracle/
HADOOP_VERSION=hadoop-2.7.1
HADOOP_FILE="$HADOOP_VERSION".tar.gz
HADOOP_MIRROR=http://mirrors.gigenet.com/apache/hadoop/common/"$HADOOP_VERSION"/"$HADOOP_FILE"
HADOOP_LOCATION=/usr/local/hadoop


#################
# Oracle Java 7 #
#################
add-apt-repository -y ppa:webupd8team/java
apt-get update
echo "export JAVA_HOME=$JAVA_HOME_DIR" >> /etc/environment
echo debconf shared/accepted-oracle-license-v1-1 select true | \
  debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
  debconf-set-selections
apt-get install -y oracle-java7-installer
#################


#########################################
# To confirm port forwarding is working #
#########################################
#http://127.0.0.1:4567/test.html
apt-get install -y apache2
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi
mkdir -p /vagrant/html/
echo HI > /vagrant/html/test.html
#########################################


##############################
# Hadoop Single Node Cluster #
##############################
apt-get install -y ssh
apt-get install -y rsync

if [ -f /vagrant/$HADOOP_FILE ] && [ ! -f $HADOOP_FILE ]
then
  cp /vagrant/$HADOOP_FILE .
elif [ ! -f $HADOOP_FILE ]
then
  wget $HADOOP_MIRROR
fi
tar -xzf $HADOOP_FILE
mv $HADOOP_VERSION $HADOOP_LOCATION
chown -R vagrant $HADOOP_LOCATION

echo "export HADOOP_HOME=$HADOOP_LOCATION" >> /etc/environment
echo "export PATH=$PATH:$HADOOP_LOCATION/bin:$HADOOP_LOCATION/sbin" >> /etc/environment
echo "export HADOOP_PREFIX=$HADOOP_LOCATION" >> /etc/environment
##############################


##################################
# Hadoop Pseudo-Distributed Mode #
##################################
ssh-keygen -t dsa -P '' -f /home/vagrant/.ssh/id_dsa
chown vagrant /home/vagrant/.ssh/id_dsa*
cat /home/vagrant/.ssh/id_dsa.pub >> /home/vagrant/.ssh/authorized_keys

cp /vagrant/hadoop/core-site.xml $HADOOP_LOCATION/etc/hadoop/
cp /vagrant/hadoop/hdfs-site.xml $HADOOP_LOCATION/etc/hadoop/
chown -R vagrant $HADOOP_LOCATION
##################################
