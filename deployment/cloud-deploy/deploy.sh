#!/bin/bash

<<<<<<< HEAD
# bash cloud-deploy/deploy-cloud-LAN.sh -i -n 32 8 -r -w -s -c 0 --wan --run
=======
# bash deploy-cloud-WAN.sh -i -n 32 8 -r -w -s -c 0 --wan --run
# bash deploy-cloud-WAN.sh -i -n 1 1 -r -w -s -c 0 --wan --run

>>>>>>> ba5dd455505639ecd7048860219163cefd7082b1

for i in {1..15}; do
    echo "$i"
    bash deploy-cloud-WAN.sh -c $i --run
    mv ../experiment-output ../experiment-output-total/experiment-output-$i
done
