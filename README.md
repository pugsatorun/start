# 初期設定のためのshellscript
ubuntu用の初期設定シェルスクリプトです  

```
$ chmod +x ubuntu-setting.sh
$ ./ubuntu-setting.sh
```
これはubuntu用の初期設定シェルスクリプトです  
setting.shを実行することで環境構築を行います  

立命館用のシェルスクリプト開発中
開発はubuntu
これから始まる異世界生活

## あって役に立つ確認コマンド

メモリ情報の確認

```
# あまり使わないかもメモリのいろいろわかる
$ cat /proc/meminfo
# メモリの速度や容量などがわかる（一番オススメ）
$ sudo lshw -class memory
```
cpuの確認

```
$ cat /proc/cpuinfo
```

端末の設定

```
# デフォルト端末を変更する
$ sudo update-alternatives --config x-terminal-emulator

# Hyperをデフォルトの端末にする
$ sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /opt/Hyper/hyper 50
```

マウスホイールの設定

```
#下記でボタン4と5だけに作用する
#設定ファイルは[~/.imwheel]に記述
# 起動
$ imwheel -b "4 5"
# 再起動
$ imwheel -k
# 停止
$ imwheel -q
```
ファイル名は[.imwheelrc]で以下を記述することで設定できる

```
".*"
None,      Up,   Button4, 2
None,      Down, Button5, 2
```

# ntpサーバーの設定と再起動

設定ファイルは/etc/systemd/timesyncd.confにある
上記ファイル内の

```diff
- #NTP=
+ NTP=[任意のサーバー]
```

設定後以下を実行することでntpサーバーをrestartできます

```
$ sudo systemctl restart systemd-timesyncd.service
```

# デフォルトの音声出力を変更する方法

はじめに接続されている機器を確認

```
# 詳しい機器の情報
$ pactl list short sources
# ひとまず何台あるか確認するのは
$ cat /proc/asound/modules
```

次にデフォルトの音声出力先を変更する
vimやnanoなどで以下のファイルを編集。以下はvimを使用した場合
$ vim /etc/pulse/default.pa

以下の文言を修正

```diff
…
### Should be after module-*-restore but before module-*-detect
- load-module module-switch-on-port-available モジュールが検出できなければ復元しない…っぽい、これを止めないと、、、

### Use hot-plugged devices like Bluetooth or USB automatically (LP: #1702794)
- .ifexists module-switch-on-connect.so
- load-module module-switch-on-connect BluetoothとかUSBがつながったら自動で切り替えるのを止める。
- .endif
…
### Make some devices default
- set-default-sink output
- set-default-source input
+ set-default-source <デバイス名>.monitor
```

# WSLの時刻ズレ問題
解決は以下のコマンドを実行

```diff
$ sudo hwclock --hctosys
```
