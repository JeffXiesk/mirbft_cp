#!/bin/bash

ssh_options_cloud='-i bft_ap.pem -o StrictHostKeyChecking=no -o LogLevel=ERROR -o UserKnownHostsFile=/dev/null -o ServerAliveInterval=60'

# source shutdown_instances.sh

totalnum=6
for ((c=1;c<=$totalnum;c++))
do
    new_instance_info=$(aws ec2 run-instances \
    --launch-template LaunchTemplateId=lt-0f484f5c1d4158d0e \
    --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="test"}]')
done
    # --launch-template LaunchTemplateId=lt-0052a4dd500c7b168 \
    # --launch-template LaunchTemplateId=lt-0854465890b2cf8e9 \

sleep 60

public_ip=$(
    aws ec2 describe-instances   \
    --filter "Name=network-interface.status,Values=available,in-use"   \
    --query "Reservations[*].Instances[*].PublicIpAddress"   \
    --output=text)
echo $public_ip



private_ip=$(
    aws ec2 describe-instances   \
    --filter "Name=network-interface.status,Values=available,in-use"   \
    --query "Reservations[*].Instances[*].PrivateIpAddress"   \
    --output=text)
echo $private_ip


# public_ip='3.89.215.211,54.164.69.129,3.95.208.219,44.211.143.100,44.211.70.46,3.87.161.236'
# private_ip='172.31.88.205,172.31.82.48,172.31.87.121,172.31.81.77,172.31.82.181,172.31.92.81'

# show info of instance
public_ip_arr=(`echo $public_ip | tr ',' ' '`)
for i in "${public_ip_arr[@]}"
do
   echo "$i"
done

private_ip_arr=(`echo $private_ip | tr ',' ' '`)
for i in "${private_ip_arr[@]}"
do
   echo "$i"
done

# set root login, reference : https://www.youtube.com/watch?v=xE_oaWVhaV4
for i in "${public_ip_arr[@]}"
do
    # send local 'sshd_config' ssh config file to instance
    scp $ssh_options_cloud sshd_config ubuntu@$i:~
    # set root login
    ssh $ssh_options_cloud ubuntu@$i "sudo cp ~/.ssh/authorized_keys /root/.ssh/authorized_keys;sudo cp ~/sshd_config /etc/ssh/sshd_config"
    echo "$i set root login done..."
done

# set ssh key
for i in "${public_ip_arr[@]}"
do
    # send local 'sshd_config' ssh config file to instance
    scp $ssh_options_cloud 'key/id_rsa' root@$i:/root/.ssh
    scp $ssh_options_cloud 'key/id_rsa.pub' root@$i:/root/.ssh
    ssh $ssh_options_cloud root@$i 'chmod 600 /root/.ssh/id_rsa;chmod 600 /root/.ssh/id_rsa.pub;echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC3JeK5VQ3cRMLp5nHeMgIDTbbOvytBR6BDy4TK0QOqzyrGIlaSt966JkTsUfxXLw7Gc/cGRwpjVcszE3nGEvcquAEHuFOfYmt8Pat3cHuLgH4p/GPwBMbvKgrLNGrkRphFugK30IPN5yRvsUhpVzi/XJJN6iL68fRzdFzmOjQWgvmOcWPTVy7VV0GjX3XoO5XcmQU3/B52nZotypxCmDN91eJyNeVjpGgDdwT+Pc6eqr1yAx4PH/PDPOSQlrFC7x8zsuiwz+F+cLaUyVNmp5G/NSzcNoYKbxohnj11JVdVgnUj/CocG9dJjpxY4+NSCAaIRJ5kczF+9VVrzfhyId4D niu@niu-Standard-PC-i440FX-PIIX-1996 >> /root/.ssh/authorized_keys'
    echo "$i sent ssh key done..."
done





# ./deploy.sh remote scripts/cloud-deploy/cloud-instance-info new scripts/experiment-configuration/generate-config.sh


# source shutdown_instances.sh

