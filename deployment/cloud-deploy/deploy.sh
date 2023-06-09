#!/bin/bash


for i in {1..15}; do
    echo "$i"
    bash deploy-cloud-WAN.sh -c $i --run
    mv ../experiment-output ../experiment-output-total/experiment-output-$i
done
