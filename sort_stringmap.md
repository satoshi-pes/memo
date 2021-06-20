### mapのkeyをsortして出力する豊富

go言語ではmapのkeyをsortして出力する機能は標準で実装されていないので、 
自分で実装する必要がある。

    keys := make([]string, 0, len(stringMap))
    for k := range stringMap {
        keys = append(keys, k)
    }
    sort.Strings(keys)
    
    for k := range keys {
        _ = stringMap[k]  // do something
    }

### satoshi-pes's GitHub Pages
[https://satoshi-pes.github.io/memo/](https://satoshi-pes.github.io/memo/)
