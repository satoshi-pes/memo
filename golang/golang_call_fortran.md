### Go言語からfortranを呼び出す方法

Go言語にはcgoという仕組みがあり、C言語の関数を呼び出すことができる。  
ただ、数値計算をする場合等にはfortranを呼びだしたいときもある。  
その場合のやり方をメモしておく。

cgoについてはGo言語のページにブログがあるので、それを読むとある程度分かる。  
[C? Go? Cgo!](https://go.dev/blog/cgo)

このように、import "C"の直上にC言語のヘッダー等を記載して、関数を呼び出せるようにする。
とても簡単。
```
package main

/*
#include <stdlib.h>
*/
```

### fortranを呼びだすには"iso_c_binding"を使う
#### iso_c_binding
さて、C言語を呼びだす分にはあまり問題ないかもしれないが、fortranを呼びだすには独特の作法を考慮しなければいけない。

fortranには、Fortran2003からiso_c_bindingという機能が加わった。これを使うと、c言語と互換性のある変数を用いることができる。また、関数名もgfortran等では勝手に"関数名_"とアンダースコアがついてしまっていたが、この関数名も指定できる。

```
function func1(v_float, v_double) result(i_int) bind(C, name="name")
    use iso_c_binding, only: c_float, c_double, c_int
    implicit none

    real(c_float), intent(in) :: v_float
    real(c_double), intent(in) :: v_double
    integer(c_int) :: i_int
```
このようにbind(C)としてC言語との互換性を確保し、nameもつけると宣言した関数名と異なる名前をつけることもできる。もうfortranもC言語みたいに使える。

ということで、Go言語からfortranを呼びだすには、基本的にはfortran側でiso_c_bindingの機能を用いた関数を用意してあげることになる。 fortran77のプログラムを呼びたいときは、iso_c_bindingを使ったラッパーを作るのが良い。

#### intent属性？
と、簡単にfortranを呼びだす仕組みはあるのだが、fortranの関数やサブルーチンに引数を渡すときは注意が必要で、それがintent属性の考慮である。

fortranの関数引数にはintent属性が指定できるのだが、それぞれこんな感じ。
```
intent(in)   : 渡した値を関数内で変更しない
intent(out)  : 値は戻されるだけでインプットされない
intent(inout): 値が渡され、関数内で変更することができる 
```

なので、c言語なんかと対応するイメージとしては、こんな感じ。
```
intent(in)   : 値渡しのようなもの
intent(out)  : return値
intent(inout): 参照渡しのようなもの
```
ただし注意が必要なのは、fortranの関数引数は参照渡しということ。なので**基本的にポインタで渡してあげる**ことになる。

#### 実装例
ちょっと実装してみると、

```
!! example 
function func1(v_float, v_double) result(i_int) bind(C)
    use iso_c_binding, only: c_float, c_double, c_int
    implicit none

    real(c_float), intent(in) :: v_float
    real(c_double), intent(in) :: v_double
    integer(c_int) :: i_int

    print *, "float : ", v_float
    print *, "double: ", v_double

    ! return value
    i_int = 42
end function func1

subroutine sub1(v_float_in, v_float_inout, v_float_out) bind(C)
    use iso_c_binding, only: c_float
    implicit none

    real(c_float), intent(in):: v_float_in
    real(c_float), intent(inout):: v_float_inout
    real(c_float), intent(out):: v_float_out

    print *, "in, inout, out (before change): ", v_float_in, v_float_inout, v_float_out

    !v_float_in = 42.  !! cannot change 
    v_float_inout = 42.
    v_float_out = 42.
end subroutine sub1
```

さて、これをGo言語側から呼びだすのに使うのがcgo。  
こんな感じで、import "C"の直上にCコードを記述する。  

上にも書いたが、fortranは引数が参照渡しなので、全てポインタで渡す必要がある。
```
package main

/*
// function func1(v_float, v_double) result(i_int)
int func1(float*, double*);

// subroutine sub1(v_float_in, v_float_inout, v_float_out)
void sub1(float*, float*, float*);
*/
import "C"

import "fmt"

func main() {
	// func1
	var v1 C.float = 1.
	var v2 C.double = 2.

	i := C.func1(&v1, &v2)
	fmt.Println(i)

	// sub1
	var c1, c2, c3 C.float
	c1, c2, c3 = 1., 2., 3.

	fmt.Println(c1, c2, c3)  // before sub1 call
	C.sub1(&c1, &c2, &c3)
	fmt.Println(c1, c2, c3)  // after sub1 call
}
```
上記を適当なフォルダに保存して、
```
example.f90
example.go
```
go mod initしてbuildするだけ。(go run example.goはできない。)
```
go mod init example
go build
./example
```

実行結果
```
 float :    1.00000000
 double:    2.0000000000000000
42
1 2 3
 in, inout, out (before change):    1.00000000       2.00000000       3.00000000
1 42 42
```
なぜかintent(out)の変数の値が渡されてしまっているが、このあたりの事情はよくわからない。（単純に知らない。）

### satoshi-pes's GitHub Pages
[https://satoshi-pes.github.io/memo/](https://satoshi-pes.github.io/memo/)
