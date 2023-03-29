# bandwidth=(5)
# # bandwidth=(300 200 20)

# len=${#bandwidth[@]}

for ((i=3;i<=5;i++)); do
    echo $i
    echo "cp scripts/experiment-configuration/generate-config_s_$i.sh scripts/experiment-configuration/generate-config.sh"
    cp scripts/experiment-configuration/generate-config_s_$i.sh scripts/experiment-configuration/generate-config.sh
    echo "bash scripts/cloud-deploy/deploy-cloud-WAN.sh -i -d"
    bash scripts/cloud-deploy/deploy-cloud-WAN.sh -i -d
    echo '======'
done

echo "bash scripts/cloud-deploy/deploy-cloud-WAN.sh -sd"
bash scripts/cloud-deploy/deploy-cloud-WAN.sh -sd
