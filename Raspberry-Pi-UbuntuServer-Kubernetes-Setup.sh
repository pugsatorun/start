#!/bin/sh

# アップデート
sudo apt update
sudo apt upgrade -y

#初期導入コマンド
sudo apt install -y curl vim nano openssh-server git build-essential

#git初期設定
git config --global user.name "pugsatoshi"
git config --global user.email "satoshi.ito.dev@gmail.com"

#日本語環境install
echo "日本語環境install"
sudo apt -y install language-pack-ja-base language-pack-ja ibus-mozc
sudo update-locale LANG=ja_JP.UTF8
sudo apt -y install manpages-ja manpages-ja-dev
#タイムゾーンを日本に変更
echo "タイムゾーンの設定"
ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/locltime
echo "タイムゾーンの設定"
#sudo timedatectl set-timezone Asia/Tokyo

#vim環境構築
mkdir ~/.vim
mkdir ~/.vim/colors
git clone https://github.com/tomasr/molokai ~/.vim/colors/molokai
cp ~/.vim/colors/molokai/colors/molokai.vim ~/.vim/colors

#任意のファイルのコピー
cp .vimrc ~/

#Dockerインストール
sudo apt-get update
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
#Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# x_86_64/amd64
#echo \
#  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# arm64
echo \
  "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo systemctl status docker
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker

# pyenv導入
# pyenv初期コマンド
sudo apt install -y \
  libffi-dev \
  libssl-dev \
  zlib1g-dev \
  liblzma-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
source ~/.bashrc
echo "pyenv導入確認"
pyenv -v
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
source ~/.bashrc

# スワップ無効化
sudo dphys-swapfile swapoff
sudo systemctl stop dphys-swapfile
sudo systemctl disable dphys-swapfile

#Dockerインストール
sudo apt-get update
sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg \
  lsb-release
#Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
# x_86_64/amd64
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
# arm64
#echo \
#  "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
#  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo systemctl status docker
sudo groupadd docker
sudo gpasswd -a $USER docker
sudo systemctl restart docker

# Kubernetes install
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo deb https://apt.kubernetes.io/ kubernetes-xenial main | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubeadm kubelet kubectl
