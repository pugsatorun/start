#!bin/sh

#アップデート
sudo apt update
sudo apt upgrade -y

#初期導入コマンド
sudo apt install -y curl vim nano openssh-server 

#任意のファイルのコピー
cp .vimrc ~/
