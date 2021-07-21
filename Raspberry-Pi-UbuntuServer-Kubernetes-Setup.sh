#!/bin/sh

# アップデート
sudo apt update
sudo apt upgrade -y

#初期導入コマンド
sudo apt install -y curl vim nano openssh-server git build-essential

#git初期設定
git config --global user.name "name"
git config --global user.email "example@mail.com"

#日本語環境install
echo "日本語環境install"
sudo apt -y install language-pack-ja-base language-pack-ja ibus-mozc
sudo update-locale LANG=ja_JP.UTF8
sudo apt -y install manpages-ja manpages-ja-dev
#タイムゾーンを日本に変更
#echo "タイムゾーンの設定"
#ln -s /usr/share/zoneinfo/Asia/Tokyo /etc/locltime
#echo "タイムゾーンの設定"
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
# Docker 生存確認
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

# Kubernetes install
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo deb https://apt.kubernetes.io/ kubernetes-xenial main | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install -y kubeadm kubelet kubectl
# バージョンの確認
kubeadm version -o json
kubectl version -o json
kubelet --version

# IPv6を停止
echo 'net.ipv6.conf.all.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.default.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.eth0.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.conf
echo 'net.ipv6.conf.lo.disable_ipv6 = 1' | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

# 要変更　Host名を変更自身の環境によって変更する必要あり
# Masterの場合
#sudo hostnamectl set-hostname Kubernates-master
# Workerの場合
#sudo hostnamectl set-hostname Kubernates-worker01

# 要変更 Hostsファイルの編集自身の構成により変更が必要
echo '192.168.11.100 master Kubernates-master' | sudo tee -a /etc/hosts
echo '192.168.11.101 worker01 Kubernates-worker01' | sudo tee -a /etc/hosts
echo '192.168.11.102 worker02 Kubernates-worker02' | sudo tee -a /etc/hosts
echo '192.168.11.103 worker03 Kubernates-worker03' | sudo tee -a /etc/hosts
echo '192.168.11.104 worker04 Kubernates-worker04' | sudo tee -a /etc/hosts
echo '192.168.11.105 worker05 Kubernates-worker05' | sudo tee -a /etc/hosts
echo '192.168.11.106 worker06 Kubernates-worker06' | sudo tee -a /etc/hosts
echo '192.168.11.107 worker07 Kubernates-worker07' | sudo tee -a /etc/hosts

# 要変更アカウント追加
#sudo adduser User
#sudo gpasswd -a User sudo

# デフォルトアカウントログイン停止
#sudo usermod -s /usr/sbin/nologin ubuntu

# iptablesがnftablesバックエンドを使用しないようにする
sudo apt-get -y install iptables arptables ebtables
sudo update-alternatives --set iptables /usr/sbin/iptables-legacy
sudo update-alternatives --set ip6tables /usr/sbin/ip6tables-legacy
sudo update-alternatives --set arptables /usr/sbin/arptables-legacy
sudo update-alternatives --set ebtables /usr/sbin/ebtables-legacy

# cgruop でmemoryの有効化
cat /proc/cgroups | grep memory
echo 'cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory' | sudo tee /boot/firmware/cmdline.txt
