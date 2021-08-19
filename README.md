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

