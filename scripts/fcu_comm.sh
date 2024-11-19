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

# FCU_PORTが設定されているかチェック
if [ -z "$FCU_PORT" ]; then
    echo "Error: FCU_PORT environment variable is not set"
    exit 1
fi

# launchファイルを起動（FCU_PORTを使用）
roslaunch hardware_utils fcu_comm.launch gcs_url:="$gcs_url" fcu_url:="${FCU_PORT}:500000"