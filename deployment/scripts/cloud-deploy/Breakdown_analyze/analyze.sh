#!/bin/bash

folder_path=$1
shift

for folder1 in "$folder_path"/*; do
    # # 检查是否是文件
    # if [ -f "$file" ]; then
    #     echo "File: $file"
    # fi

    # 检查是否是文件夹
    if [ -d "$folder1" ]; then
        # echo "Directory1: $folder1"
        name=$(basename $folder1)
        echo "Directory name1: $name"
        python analyze.py $folder1
    fi
done