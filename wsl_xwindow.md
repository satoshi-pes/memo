## wslのxwindow設定

wslでxwindowを使っていたらいくつかエラーが出たので、その回避方法のメモ。

まず、x11-appsをインストール。

	sudo apt install x11-apps

その後、.bashrcに下記を追加。

	export DISPLAY=192.168.1.20:0.0
	export XDG_RUNTIME_DIR=/tmp/runtime-xxxxxx
	export RUNLEVEL=3
	export LIBGL_ALWAYS_INDIRECT=1

ここで、DISPLAYにはxserver側のIPアドレスと、使うディスプレイ番号を指定する。面倒なので、IPアドレスは固定にした。
また、その他の設定は、wslでサポートしていない(?)libGLによるハードウェアレンダリングをオフにしたりというもの。

あとは、適当なXserverをwindowsにインストールして完了。

### satoshi-pes's GitHub Pages
[https://satoshi-pes.github.io/memo/](https://satoshi-pes.github.io/memo/)
