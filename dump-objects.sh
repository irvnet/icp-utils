#!/bin/bash

# make a place to stash stuff

for n in $(kubectl get -o=name pvc,configmap,serviceaccount,secret,ingress,service,deployment,statefulset,hpa,job,cronjob)
do
    mkdir -p $(dirname ./cluster-dump/$n)
    kubectl get -o=yaml --export $n > ./cluster-dump/$n.yaml
done

