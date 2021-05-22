## Go言語でファイル解凍しながら読み込み

直接圧縮ファイルを読み込みながら処理したい時がある。  
容量の問題で解凍したファイルを取っておくのも嫌だし、とはいえ毎回解凍するのも面倒、という時。

ということで、サンプルコード。

go言語で.Z形式のファイルをdecompressするものは標準ライブラリに無さそうだったので、下記のパッケージを使用。

[hotei/dcompress](call-module-codehttps://github.com/hotei/dcompress)


    package main

    import (
        "fmt"
	    "path"
	    "bufio"
	    "compress/bzip2"
	    "compress/gzip"

	    "github.com/hotei/dcompress"
    )
    
    func main() {
    	file1 := "example.Z"

	    f, err := os.Open(file1)
	    if err != nil {
	    	fmt.Println(err)
	    	panic("error")
	    }
	    defer f.Close()

	    s := bufio.NewScanner(f)
	    switch path.Ext(file1) {
	    case ".Z":
	    	r, err := dcompress.NewReader(f)
	    	if err != nil {
	    		panic(err)
	    	}
	    	s = bufio.NewScanner(r)
	    case ".gz":
	    	r, err := gzip.NewReader(f)
	    	if err != nil {
	    		panic(err)
	    	}
	    	s = bufio.NewScanner(r)
	    case ".bz2":
	    	r := bzip2.NewReader(f)
	    	s = bufio.NewScanner(r)
	    }
    
        // check output
	    for i := 0; s.Scan(); i++ {
	    	line := s.Text()
	    	fmt.Println(i, line)
	    }
    }