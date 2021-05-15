### github.com/spf13/cobraの挙動

ちょっとハマったのでメモ。  
実行時は、下記の順に呼び出される。  
引数と設定ファイルのパラメータを混在させる時は注意。

    cmd.init()  // command line 引数処理
    root.initConfig()  // config file 読み込み
    cobra.command()  // subcommand 実行

