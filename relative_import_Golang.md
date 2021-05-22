## Go言語で相対インポート

以前のGo言語では、ソース上で相対インポートも可能だったけれど、最近はそれができなくなった。  
とはいえ、軽くテストしたい時はそれも不便だったりするので、go.modで相対インポートができるようになっている。

[Call your code from another module](https://golang.org/doc/tutorial/call-module-code)

手順としては、とりあえずソースでは適当なモジュール名でインポートしておく。

    package main
    
    import (
        "fmt"
    
        "example.com/greetings"
    )
    
    func main() {
        // Get a greeting message and print it.
        message := greetings.Hello("Gladys")
        fmt.Println(message)
    }

その後、go modでdummyのモジュール設定をする。  
下記の-replaceの部分で置き換えるモジュールの実際のパスを指定する。

    >> go mod init
    >> go mod edit -replace=example.com/greetings=../greetings
    >> go mod tidy

すると、go.modが下記のように更新され、相対インポートのパスが書き込まれる。

    module example.com/hello
    
    go 1.16
    
    replace example.com/greetings => ../greetings
    
    require example.com/greetings v0.0.0-00010101000000-000000000000

これで、go run main.goのように実行可能になる。  

若干面倒かもしれないけど、慣れればそれほどでもないし、モジュール名も本番用のまま書き始められて、良いことの方が多い気はする。

### satoshi-pes's GitHub Pages
[https://satoshi-pes.github.io/memo/](https://satoshi-pes.github.io/memo/)
