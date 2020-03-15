docker-mirakurun-epgstation-plex
====

[Mirakurun](https://github.com/Chinachu/Mirakurun) + [EPGStation](https://github.com/l3tnun/EPGStation) の Docker コンテナ

[docker-mirakurun-epqstation](https://github.com/l3tnun/docker-mirakurun-epqstation)のフォーク。
PLEX PX-W3U4/Q3U4/W3PE4/Q3PE4 チューナー + ACR39-NTTComを利用



## 前提条件
下記のインストールが完了している
- Docker
- docker-compose
- [px4_drv](https://github.com/nns779/px4_drv)

また、下記のデバイスがUSB経由で接続・認識されている
- PLEX PX-W3U4/Q3U4/W3PE4/Q3PE4
- ACR39-NTTCom



## インストール手順

```
$ git clone https://github.com/s-naoya/docker-mirakurun-epgstation-plex
$ cd docker-mirakurun-epgstation-plex
$ sudo docker-compose pull
$ sudo docker-compose build

# BS, CSのチャンネル設定
$ vim mirakurun/conf/channels.yml

# devicesを編集
$ vim docker-compose.yml
```



## 起動

```
$ sudo docker-compose up -d
```
mirakurun の EPG 更新を待ってからブラウザで http://DockerHostIP:8888 へアクセスし動作を確認する

地上波のチャンネル設定
```
curl -X PUT "http://DockerHostIP:40772/api/config/channels/scan"
```


## 停止

```
$ sudo docker-compose down
```

## 設定

### Mirakurun

- ポート番号: 40772

### EPGStation

- ポート番号: 8888
- ポート番号: 8889

### 各種ファイル保存先

- 録画データ

```./recorded```

- サムネイル

```./epgstation/thumbnail```

- 予約情報と HLS 配信時の一時ファイル

```./epgstation/data```

- EPGStation 設定ファイル

```./epgstation/config```

- EPGStation のログ

```./epgstation/logs```



## 稼働環境

下記の環境で稼働を確認している
- NUC6CAYH
- Ubuntu Server 18.04


## TODO
- カードリーダーのUSB番号を自動取得
