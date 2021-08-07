#!/bin/bash

# 入力箇所
hostname="データベースホスト名"
user="ユーザ名"
dbname="データベース名"
password="データベースのパスワード"
bkupdir="バックアップ先のフルパス(末尾にスラッシュ不要)"
wpdir="wp-contentのフルパス(末尾にスラッシュ不要)"
shdir="このシェルスクリプトを格納しているディレクトリ(末尾にスラッシュ不要)"
daletenum="バックアップファイルの上限数"

# 入力不要
date=`date +%Y%m%d%H%M%S`
dumpdir="${bkupdir}/$date"
dbquery="/usr/bin/mysqldump -h $hostname -u $user -p$password --databases $dbname"

# 実行
eval "mkdir $dumpdir"
eval "$dbquery > ${dumpdir}/dbdump.sql"
eval "cp -a $wpdir ${dumpdir}"
eval "cd $bkupdir && zip -rm ${date}.zip ${date}"

# 古い順に削除
eval "cd $bkupdir && python rm.py $daletenum"
