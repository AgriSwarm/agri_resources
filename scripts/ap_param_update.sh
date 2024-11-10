#!/bin/bash

# レポジトリのパスを設定
REPO_PATH=$(rospack find agri_resources)/config/ardupilot

# 現在の日時を取得（コミットメッセージ用）
DATETIME=$(date '+%Y-%m-%d_%H-%M-%S')

# レポジトリに移動
cd $REPO_PATH

# 変更をステージングエリアに追加
git add .

# 変更をコミット
git commit -m "Update: $DATETIME"

# mainブランチにプッシュ
git push origin main

echo "Successfully pushed to repository"