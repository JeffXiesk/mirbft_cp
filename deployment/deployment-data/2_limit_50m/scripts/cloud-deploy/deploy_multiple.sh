bandwidth=(500 200 100 50 20 10)

len=${#bandwidth[@]}

for ((i=0; i < len; i++)); do
    echo ${bandwidth[$i]} 
    echo '-----'
done