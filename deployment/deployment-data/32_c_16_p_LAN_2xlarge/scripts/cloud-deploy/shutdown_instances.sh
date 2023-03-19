#!/bin/bash

instances_id=$(
    aws ec2 describe-instances  \
    --filter "Name=network-interface.status,Values=available,in-use"   \
    --query "Reservations[*].Instances[*].InstanceId"   \
    --output=text)
# echo $instances_id

instances_id_arr=(`echo $instances_id | tr ',' ' '`)
for i in "${instances_id_arr[@]}"
do
   echo "$i"
done


for i in "${instances_id_arr[@]}"
do
    terminate_instance_info=$(aws ec2 terminate-instances --instance-ids $i)
    echo $terminate_instance_info
done


