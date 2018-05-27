
#!/bin/bash

# make sure nfs SERVER is installed
sudo apt-get install nfs-kernel-server -y

count=1
client="0.0.0.0" #icp master public ip

while [ $count -lt 100 ]
do
  DNAME=/nfs/VOL$(printf %03d $count)

  if [ ! -d $DNAME ]; then

    # create the directory
    sudo mkdir -p $DNAME
    echo "created $DNAME"

    # update the exports file
    line="$DNAME    $client(rw,sync,no_subtree_check)"
    echo $line | sudo tee -a /etc/exports

  fi

  count=`expr $count + 1`
done

# make it available for nfs
sudo chmod -R 777 /nfs
sudo chown -R nobody:nogroup /nfs

# restart nfs
sudo systemctl restart nfs-kernel-server
sudo exportfs -ra


