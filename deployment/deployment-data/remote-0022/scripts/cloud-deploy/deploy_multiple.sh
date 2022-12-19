bandwidth=(500 150 100 50 10)
# bandwidth=(300 200 20)

len=${#bandwidth[@]}

for ((j=1;j<=3;j++)); do
    for ((i=0; i < len; i++)); do
        echo $j ${bandwidth[$i]} >> scripts/cloud-deploy/execute_order.log
        # echo "source scripts/cloud-deploy/deploy-cloud.sh -b $j ${bandwidth[$i]}"
        scripts/cloud-deploy/deploy-cloud.sh -i -b $j ${bandwidth[$i]}
        echo '======'
    done
    echo '-----'
done