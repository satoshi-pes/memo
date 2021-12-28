## wslでfont追加

wslでmatplotlibを使っていたら、フォントがインストールされていないと文句を言われたので、その解決方法のメモ。

まず、~/.local/share/fontsにインストールしたいフォントを置く。

	cp font.zip ~/.local/share/fonts/
	cd ~/.local/share/fonts/
	unzip font.zip

その後、fc-matchでフォントが見つかるか確認。

	fc-match font

ただ、これだけだとmatplotlibのフォントが変更されない。

原因はmatplotlibのフォントキャッシュらしい。
容赦なくキャッシュを削除する。これでOK。

	rm ~/.cache/matplotlib/fontlist-v330.json

あとは、matplotlibで使いたいフォントを指定すればOK。

	    plt.rcParams["font.family"] = "font"   # さっき入れたフォント


### satoshi-pes's GitHub Pages
[https://satoshi-pes.github.io/memo/](https://satoshi-pes.github.io/memo/)
