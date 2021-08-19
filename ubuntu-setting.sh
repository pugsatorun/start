#!/bin/sh

#アップデート
sudo apt update
sudo apt upgrade -y

#初期導入コマンド
sudo apt install -y curl vim nano openssh-server git build-essential

#ディレクトリの英語化
LANG=C xdg-user-dirs-gtk-update

#CAPSキーをctrlにする
echo "setxkbmap -model jp106 -layout jp -option ctrl:nocaps" | sudo tee -a ~/.bashrc

#openコマンド(Mac信者のため)
echo "open='xdg-open'"

#PATHを短くする
echo "export PS1='\[\033[32m\]\u:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\$ '" | sudo tee -a ~/.bashrc

#git初期設定
git config --global user.name "name"
git config --global user.email "mail@com"

#日本語環境install
#echo "日本語環境install"
#sudo apt -y install language-pack-ja-base language-pack-ja ibus-mozc
#sudo update-locale LANG=ja_JP.UTF8
#sudo apt -y install manpages-ja manpages-ja-dev
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

#人を信用するな
echo "alias rm='rm -i'" | sudo tee -a ~/.bashrc
echo "alias mv='mv -i'" | sudo tee -a ~/.bashrc
echo "alias cp='cp -i'" | sudo tee -a ~/.bashrc
echo "alias rm='rm -i'" | sudo tee -a /etc/profile
echo "alias mv='mv -i'" | sudo tee -a /etc/profile
echo "alias cp='cp -i'" | sudo tee -a /etc/profile

# GPUを使う場合
#動いてるGPUドライバの確認
lsmod | grep nouveau
#抹殺するためのコマンド
echo '' >> /etc/modprobe.d/blacklist.conf
echo 'blacklist nouveau' >> /etc/modprobe.d/blacklist.conf
echo 'options nouveau modeset=0' >> /etc/modprobe.d/blacklist.conf
sudo update-initramfs -u
# sudo reboot
#いらないかも
sudo add-apt-repository ppa:graphics-drivers/ppa
ubuntu-drivers devices
sudo ubuntu-drivers autoinstall
#CUDAのインストール
#鍵を追加(ubuntu 20.04)
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update
sudo apt-get -y install cuda
sudo apt install -y \
  freeglut3 \
  freeglut3-dev \
  libegl-dev \
  libfreeimage-dev \
  libfreeimage3 \
  libgles2-mesa-dev \
  libglfw3-dev \
  libglu1-mesa \
  libglu1-mesa-dev \
  libxi-dev \
  libxmu-dev \
  mesa-common-dev
# PATHの追加
echo 'export PATH="/usr/local/cuda/bin:$PATH"' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"' >> ~/.bashrc
# cuDNNの導入

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
