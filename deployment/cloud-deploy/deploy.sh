#!/bin/bash

# bash cloud-deploy/deploy-cloud-LAN.sh -i -n 32 8 -r -w -s -c 0 --wan --run

for i in {1..15}; do
    echo "$i"
    bash deploy-cloud-WAN.sh -c $i --run
    mv ../experiment-output ../experiment-output-total/experiment-output-$i
done
