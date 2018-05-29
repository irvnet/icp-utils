#!/bin/bash

count=1
NS=""
USERNAME=""

# make a bunch o namespaces
while [ $count -lt 31 ]
do
  USERNAME=user$(printf %02d $count)
  NS=$USERNAME-ns
  kubectl create namespace $NS
  echo "new namespace: $NS"

  count=`expr $count + 1`
done

