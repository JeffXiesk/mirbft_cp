# bandwidth=(5)
# bandwidth=(300 200 20)

len=${#bandwidth[@]}

for ((i=2;i<=5;i++)); do
    echo $i 30
    echo "source scripts/cloud-deploy/deploy-cloud.sh -b $i 30"
    bash scripts/cloud-deploy/deploy-cloud-WAN.sh -b $i 30 -d
    echo '======'
done

bash scripts/cloud-deploy/deploy-cloud.sh -sd
