#!/bin/sh

#アップデート
sudo apt update
sudo apt upgrade -y

#初期導入コマンド
sudo apt install -y curl vim nano openssh-server git 

#git初期設定
git config --global user.name "pugsatoshi"
git config --global user.email "satoshi.ito.dev@gmail.com"

#日本語環境install
#echo "日本語環境install"
#sudo apt -y install language-pack-ja-base language-pack-ja ibus-mozc
#sudo update-locale LANG=ja_JP.UTF8
#sudo apt -y install manpages-ja manpages-ja-dev
#タイムゾーンを日本に変更
#echo "タイムゾーンの設定"
#ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/locltime
echo "タイムゾーンの設定"
sudo timedatectl set-timezone Asia/Tokyo

#vim環境構築
mkdir ~/.vim
mkdir ~/.vim/colors
git clone https://github.com/tomasr/molokai ~/.vim/colors/molokai
cp ~/.vim/colors/molokai/colors/molokai.vim ~/.vim/colors

#任意のファイルのコピー
cp .vimrc ~/

#立命館
echo NTP = ntp.ritsumei.ac.jp | sudo tee -a /etc/systemd/timesyncd.conf
#標準出力なくす場合
#echo NTP = ntp.ritsumei.ac.jp | sudo tee -a /etc/systemd/timesyncd.conf > /dev/null

#人を信用するな
echo alias rm='rm -i' | sudo tee -a ~/.bashrc
echo alias mv='mv -i' | sudo tee -a ~/.bashrc
echo alias cp='cp -i' | sudo tee -a ~/.bashrc
echo alias rm='rm -i' | sudo tee -a /etc/profile
echo alias mv='mv -i' | sudo tee -a /etc/profile
echo alias cp='cp -i' | sudo tee -a /etc/profile
