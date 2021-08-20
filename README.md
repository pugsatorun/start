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

```ruby:.imwheelrc
".*"
None,      Up,   Button4, 2
None,      Down, Button5, 2
```
