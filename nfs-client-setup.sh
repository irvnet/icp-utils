#!/bin/bash

# make sure nfs CLIENT is installed
sudo apt-get install nfs-common -y

# create a place to do all the mounts
sudo mkdir /nfs
sudo chmod -R 777 /nfs
sudo chown -R nobody:nogroup /nfs

count=1
server="0.0.0.0" # nfs server is the server

while [ $count -lt 100 ]
do
  DNAME=/nfs/VOL$(printf %03d $count)

  if [ ! -d $DNAME ]; then

    # create the mount point
    sudo mkdir -p $DNAME
    echo "created $DNAME"

    # mount the nfs directory
    echo "sudo mount $server:$DNAME $DNAME"
    sudo mount $server:$DNAME $DNAME

  fi

  count=`expr $count + 1`
done


