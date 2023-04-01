# bandwidth=(5)
# bandwidth=(300 200 20)

# len=${#bandwidth[@]}

# bash scripts/cloud-deploy/deploy-cloud-WAN.sh -i -r -k
for ((i=3;i<=4;i++)); do
    echo '======'
    # echo "cp scripts/experiment-configuration/generate-config-$i.sh scripts/experiment-configuration/generate-config.sh"
    # cp scripts/experiment-configuration/generate-config-$i.sh scripts/experiment-configuration/generate-config.sh
    echo "source scripts/cloud-deploy/deploy-cloud.sh -b $i 30 -d"
    bash scripts/cloud-deploy/deploy-cloud-WAN.sh -b $i 30 -d
    echo '======'
done

bash scripts/cloud-deploy/deploy-cloud-WAN.sh -sd
