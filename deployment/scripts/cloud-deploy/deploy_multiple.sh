# bandwidth=(5)
# # bandwidth=(300 200 20)

# len=${#bandwidth[@]}

echo "bash scripts/cloud-deploy/deploy-cloud-LAN.sh -d"
bash scripts/cloud-deploy/deploy-cloud-LAN.sh -d
echo '=============================='

aws configure set region us-east-1
new_instance_info=$(aws ec2 run-instances \
 --launch-template LaunchTemplateId=lt-0854465890b2cf8e9 \
 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="Parallel-bft-instance"}]' \
 --count 8)
 
echo "sleep 60 seconds"
sleep 60

for ((i=1;i<=2;i++)); do
    echo $i
    echo "cp scripts/experiment-configuration/generate-config_s_$i.sh scripts/experiment-configuration/generate-config.sh"
    cp scripts/experiment-configuration/generate-config_s_$i.sh scripts/experiment-configuration/generate-config.sh
    echo "bash scripts/cloud-deploy/deploy-cloud-LAN.sh -i -k -d"
    bash scripts/cloud-deploy/deploy-cloud-LAN.sh -i -k -d
    echo '=============================='
done

aws configure set region us-east-1
new_instance_info=$(aws ec2 run-instances \
 --launch-template LaunchTemplateId=lt-0854465890b2cf8e9 \
 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="Parallel-bft-instance"}]' \
 --count 16)

echo "sleep 60 seconds"
sleep 60

for ((i=3;i<=4;i++)); do
    echo $i
    echo "cp scripts/experiment-configuration/generate-config_s_$i.sh scripts/experiment-configuration/generate-config.sh"
    cp scripts/experiment-configuration/generate-config_s_$i.sh scripts/experiment-configuration/generate-config.sh
    echo "bash scripts/cloud-deploy/deploy-cloud-LAN.sh -i -k -d"
    bash scripts/cloud-deploy/deploy-cloud-LAN.sh -d
    echo '=============================='
done

aws configure set region us-east-1
new_instance_info=$(aws ec2 run-instances \
 --launch-template LaunchTemplateId=lt-0854465890b2cf8e9 \
 --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value="Parallel-bft-instance"}]' \
 --count 32)

echo "sleep 60 seconds"
sleep 60

for ((i=5;i<=6;i++)); do
    echo $i
    echo "cp scripts/experiment-configuration/generate-config_s_$i.sh scripts/experiment-configuration/generate-config.sh"
    cp scripts/experiment-configuration/generate-config_s_$i.sh scripts/experiment-configuration/generate-config.sh
    echo "bash scripts/cloud-deploy/deploy-cloud-LAN.sh -i -k -d"
    bash scripts/cloud-deploy/deploy-cloud-LAN.sh -i -k -d
    echo '=============================='
done


echo "bash scripts/cloud-deploy/deploy-cloud-LAN.sh -sd"
bash scripts/cloud-deploy/deploy-cloud-LAN.sh -sd
