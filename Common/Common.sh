#! /bin/bash
#
# 共通関数定義クラス

#共通設定クラスインポート
source "$(pwd)/Common/Config.sh"

#######################################
# 挨拶の関数
# 引数:
#   なし
# リターン:
#   挨拶文字
#######################################
function Hello() {
    echo "Hello!!!"
    Now
}

#######################################
# 時刻の取得
# 引数:
#   なし
# リターン:
#   時刻
#######################################
function Now() {
    echo "It's $(date +%r)"
}

#######################################
# 加算の関数
# 引数:
#   引数１
#   引数２
# リターン:
#   加算の結果
#######################################
function Add() {
    x=$1
    y=$2
    total=$((${x} + ${y}))
    echo ${total}
}

#######################################
# ログ出力
# 引数:
#   引数１
#   引数２
#    ...
# リターン:
#   ログファイル
#######################################
LogOut() {
    echo "[${USER}][$(date +%Y%m%d_%H%M%S)] - ${*}" >>${LOG_FILE}
}

#######################################
#　ファイル移動
# 引数:
#   元ディレクトリ
#   先ディレクトリ
#    ファイルの拡張子
# リターン:
#   ファイル移動結果
#######################################
function MoveAllFiles() {
    #引数数量チェック
    if [ $# -ne 3 ]; then
        # body
        LogOut "引数は３で設定してください。"　"設定されている引数は　$#　である"
        exit 172
    fi

    srcPath=$1
    desPath=$2
    filetype=$3
    #コピー元のディレクトリ存在チェック
    if [ ! -d "$srcPath" ]; then
        LogOut "コピー元のディレクトリが存在しません。"　${srcPath}
        exit 173
    fi
    #ファイル検索
    find -name ${srcPath}*.${filetype}
    #検索コマンド結果チェック
    if [ $? -ne 0 ]; then
        # 異常場合
        LogOut "対象ファイルが存在しない。"　${filetype}
        exit 174
    fi

    #コピー先のディレクトリ存在チェック
    if [ ! -d "$desPath" ]; then
        mkdir ${desPath}
    fi
    #ファイル移動実行
    mv ${srcPath}/*.${filetype} ${desPath}
    #移動コマンド結果チェック
    if [ $? -eq 0 ]; then
        # 正常場合
        LogOut "ファイル移動が正常終了"
    else
        # 異常場合
        LogOut "ファイル移動が異常終了。エラーが発生されている。"
    fi

}
