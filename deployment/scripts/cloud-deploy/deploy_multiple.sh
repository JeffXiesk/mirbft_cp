#!/bin/bash

# bandwidth=(5)
# # bandwidth=(300 200 20)

# len=${#bandwidth[@]}

# bash scripts/cloud-deploy/deploy-cloud-WAN.sh -i -r -k
# for ((i=1;i<=5;i++)); do
#     echo $i
#     echo "cp scripts/experiment-configuration/generate-config_s_$i.sh scripts/experiment-configuration/generate-config.sh"
#     cp scripts/experiment-configuration/generate-config_s_$i.sh scripts/experiment-configuration/generate-config.sh
#     echo "bash scripts/cloud-deploy/deploy-cloud-WAN.sh -d"
#     bash scripts/cloud-deploy/deploy-cloud-WAN.sh -d
#     echo '======'
# done



bash scripts/cloud-deploy/deploy-cloud-WAN.sh -i -r -k

echo '==========ISS-no-delay=========='
# bash scripts/cloud-deploy/deploy-cloud-WAN.sh -d

echo '==========ISS-delay-20s=========='
sed -i '202s/4000/20000/' /opt/gopath/src/github.com/hyperledger-labs/mirbft/orderer/pbftinstance.go
bash scripts/cloud-deploy/deploy-cloud-WAN.sh -d

echo '==========ISS-delay-30s=========='
sed -i '202s/20000/30000/' /opt/gopath/src/github.com/hyperledger-labs/mirbft/orderer/pbftinstance.go
bash scripts/cloud-deploy/deploy-cloud-WAN.sh -d

echo '==========ISS-delay-40s=========='
sed -i '202s/30000/40000/' /opt/gopath/src/github.com/hyperledger-labs/mirbft/orderer/pbftinstance.go
bash scripts/cloud-deploy/deploy-cloud-WAN.sh -d

echo '==========ISS-delay-50s=========='
sed -i '202s/40000/50000/' /opt/gopath/src/github.com/hyperledger-labs/mirbft/orderer/pbftinstance.go
bash scripts/cloud-deploy/deploy-cloud-WAN.sh -d


echo "bash scripts/cloud-deploy/deploy-cloud-WAN.sh -sd"
bash scripts/cloud-deploy/deploy-cloud-WAN.sh -sd
