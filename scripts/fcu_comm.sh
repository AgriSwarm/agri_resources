#!/bin/bash

# 引数の数をチェック
if [ "$#" -ne 1 ]; then
    echo "Usage: test <ip_address>"
    exit 1
fi

# IPアドレスを取得
ip_address=$1

# gcs_urlを作成
gcs_url="udp://:14555@${ip_address}:14550"

# launchファイルを起動
roslaunch mavros apm.launch gcs_url:="$gcs_url"