#!/bin/bash

BACKUP_DIR=/backup

echo Start EPGStation Backup at `date`

# npm run backup $BACKUP_DIR/$(date +%s_%F)_tv_backup.json
mysqldump --single-transaction --quick -u root --password=${MYSQL_ROOT_PASSWORD} -h ${EPGST_DB_HOST} ${MYSQL_DATABASE} > /backup/$(date +%s_%F)_tv_backup.dump
echo /backup/$(date +%s_%F)_tv_backup.dump

rsync -rlOtcvx --delete /usr/local/EPGStation/recorded $BACKUP_DIR
rsync -rlOtcvx --delete /usr/local/EPGStation/data $BACKUP_DIR
rsync -rlOtcvx --delete /usr/local/EPGStation/config $BACKUP_DIR
rsync -rlOtcvx --delete /usr/local/EPGStation/thumbnail $BACKUP_DIR
rsync -rlOtcvx --delete /usr/local/EPGStation/logs $BACKUP_DIR


### 古いバックアップファイルを削除
BACKUP_KEEP_TIME=604700  # 保持秒数 7*24*60*60-100で7日間設定
for pathfile in `ls -F $BACKUP_DIR | grep -v /`; do  # BACKUP_DIR内の全ファイル（ディレクトリを除外）
    utime=`echo $pathfile | cut -d'_' -f 1`  # ファイル名先頭のUNIX TIMEを抽出
    difftime=$(($(date +%s)-$utime))  # 現在時間とファイル作成時間の差分

    # difftimeがBACKUP_KEEP_TIME以上だった場合、対象ファイルを削除
    if [ $difftime -gt $BACKUP_KEEP_TIME ]; then
        echo delete $BACKUP_DIR/$pathfile
        rm $BACKUP_DIR/$pathfile
    fi
done

ls $BACKUP_DIR
echo Finish EPGStation Backup at `date`

