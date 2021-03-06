# Portable Docker for Windows (PDW)

Portable Docker for Windows(PDW)はWindows上でQemuを利用した管理者権限不要のポータブルなLinux及びDocker環境を自動で構築するためのスクリプト群です。

概ね何をやってるのか把握したい人や手動でやりたい人は[こちら](https://qiita.com/riafeed/items/c7729dc84191e93f0f3d)をどうぞ。

## 用意するもの

ポータブル利用するには16GB以上の比較的書き込みが高速なUSBメモリまたはポータブルSSDが必要です、これが遅いと書き込み速度に引っ張られて動作が遅くなります。ランダム書き込み速度が重要なのでパッケージ等で公称されている速度(大抵シーケンシャル書込速度)が高ければいいとは限りません。PCの環境にも影響するので注意しましょう。個人差はあるでしょうが、CrystalDiskmarkで右下2つのランダム書き込み速度を示す値が1.0を超えないと辛いと思います。ポータブルSSDの場合はよほど粗悪品か不良品でもない限りこの基準は満たしてるんじゃないかと思います。

32GB以下のUSBメモリの場合、ファイルシステムがFAT32だと4GBのファイルサイズ制限に引っかかるので、NTFSかexFATにフォーマットしておく必要があります。

もちろんWindowsPCとインターネット環境は必須ですが自己所有である必要はありません。他人が管理するPCを使用する場合はルールを守りましょう。

## インストール方法

コマンドプロンプトを開き、cdコマンドやドライブの移動でインストールしたいフォルダをカレントディレクトリにした後、以下のコマンドを実行します。手入力は困難なので、下のコマンドをコピーし、コマンドプロンプト上で右クリックして貼り付けましょう。

```bat
curl -L -o .\pdw.zip https://github.com/uniras/Portable-Docker-for-Windows/archive/master.zip^
 & %windir%\system32\tar -xf pdw.zip -C .\^
 & del /q .\pdw.zip^
 & cd .\Portable-Docker-for-Windows-master^
 & set QEMU_HDD_DEF_SIZE=10G & .\script\setup.bat
```

使用するソフトウェアのダウンロードから展開・セットアップまですべて自動で行います。

関連ファイルはgithubの仕様の関係で上記コマンドを実行したカレントディレクトリ内のPortable-Docker-for-Windows-masterディレクトリにインストールされます。
気に入らない場合はインストール後にフォルダ名を変更してください。

デフォルトでは仮想HDDの容量は10GBで作成されますので、足りないと思う場合は上記コマンド内のQEMU_HDD_DEF_SIZEの値を変更してください。

仮想HDDのサイズ自体を拡張するのは簡単ですが(qcow2は縮小できないらしい)、Linuxがインストールされているパーティションのサイズを(内容を消さずに)後で拡張するのは難しいようです。

仮想HDDの内容が消えてもいいのならQEMU_HDD_DEF_SIZEを必要なサイズに設定してscriptフォルダのinstall.batを実行すれば、すでにダウンロード・展開されているファイルを元に再度設定したサイズで再インストールされます。

```bat
set QEMU_HDD_DEF_SIZE=10G & .\script\install.bat
```

### PortableGitもDocker CLIも不要な場合

WindowsからDocker使う予定がないなど、ダウンロード、インストールするソフトウェアを必要最小限にしたい場合には。
以下を貼り付けて実行してください。

```bat
curl -L -o .\pdw.zip https://github.com/uniras/Portable-Docker-for-Windows/archive/master.zip^
 & %windir%\system32\tar -xf pdw.zip -C .\^
 & del /q .\pdw.zip^
 & cd .\Portable-Docker-for-Windows-master^
 & set QEMU_HDD_DEF_SIZE=10G &　set LIGHT_MODE_INSTALL=1 & .\script\setup.bat
```

### PortableGitを手動でダウンロードする場合

Windows10が古くcurlが無いまたは信条があり使いたくないなどの場合には[PortableGit(Git for Windows)](https://github.com/git-for-windows/git/releases/)をあらかじめダウンロードしておく方法があります。

PortableGit-(バージョン)-64-bit.7z.exeをダウンロードしてPortableGit.exeにリネームし、インストールしたいフォルダに移動しておきます。

あとはコマンドプロンプトを開き、インストールしたいフォルダにカレントディレクトリを移動して以下のコマンドを実行します。

```bat
start /w PortableGit.exe -o.\Portable-Docker-for-Windows-master\app\PortableGit -y^
 & .\Portable-Docker-for-Windows-master\app\PortableGit\mingw64\bin\curl -L -o .\pdw.zip https://github.com/uniras/Portable-Docker-for-Windows/archive/master.zip^
 & .\Portable-Docker-for-Windows-master\app\PortableGit\usr\bin\unzip pdw.zip -d .\^
 & del /q .\pdw.zip^
 & cd .\Portable-Docker-for-Windows-master^
 & set QEMU_HDD_DEF_SIZE=10G & .\script\setup.bat
```

## 使用方法

インストール後、start.batをダブルクリックするとQemuを起動します。しばらく(1～2分くらい)後にssh.batをダブルクリックしてssh接続するとssh経由でLinuxを操作することができます。

ユーザー名はroot、パスワード無しの設定になっています。

dockerconsole.batはQemuを起動し、Linuxの起動を待ってDocker CLIを使える状態でコマンドプロンプトを起動します。Windowsのコマンドプロンプトではなく、PortableGitのbashを使いたい場合はdockerbash.batを起動します。

halt.batはssh経由でLinuxをシャットダウンするコマンドを送信してLinux/Qemuを終了します。

## 各種スクリプトファイルの説明

ルートフォルダ

- dockerconsole.bat　Qemuを起動し、Linuxのブートを待ってDocker CLIが使える状態でコマンドプロンプトを起動します。
- dockerbash.bat  Qemuを起動し、Linuxのブートを待ってDocker CLIが使える状態でPortableGitのbashを起動します。
- halt.bat　SSH経由でLinuxをシャットダウンし、Qemuが終了するまで待機します。
- ssh.bat　SSHを起動してLinuxに接続します(scriptフォルダのdockerssh.batを呼び出します)
- start.bat　Qemuを起動してLinuxをブートします。Linuxのブートが終了するまで待機します。

scriptフォルダ

- boot.bat  Qemuを起動してLinuxをブートします。Linuxのブート終了を待機しません。
- config.bat　各種設定を環境変数として設定しています。設定変更する場合はこのファイルを書き換えます。
- dockerconfig.bat　Docker CLIの動作に必要な環境変数を設定します。
- dockerssh.bat  SSHを起動してLinuxに接続します。コマンドラインでdockerssh.batの後にコマンドを入力するとそのコマンドをSSHを通じてLinux上で実行します。
- download.bat　セットアップに必要な各種ソフトウェアをダウンロードします。
- downloadconfig.bat　ソフトウェアのURLや保存先等を環境変数として設定しています。
- install.bat  QemuにLnuxのインストール・セットアップを行います。HDDイメージは初期化されます。
- setup.bat　セットアップを開始します。すでにセットアップが終了している場合でも全て初期化して再度ダウンロード・セットアップしますので注意してください。
- startwait.bat　TeraTermマクロを利用してLinuxがブート中の場合はLinuxのブート完了まで待機します。ブート済みの場合はすぐに終了します。
- stop.bat  SSH経由でLinuxとQemuをシャットダウンします。Linuxのシャットダウン処理やQemuの終了は待機しません。
- stopwait.bat　TeraTermマクロを利用してLinuxとQemuが正常にシャットダウンされるまで待機します。このバッチファイルは待機するだけでシャットダウンはしません。
- setup.sh  AlpineLinuxインストール後に実行するセットアップ用のシェルスクリプトです。Teratermマクロ経由で転送・実行します。
- *.ttl  Teratermマクロです
- 拡張子なしファイル  bash用のシェルスクリプトで、同名のバッチファイルを呼び出します。answerfileはAlpineLinuxインストール用の設定ファイルです。

app\Appinfoフォルダ

- appinfo.ini  PortableAppsランチャーで各種スクリプトをソフトウェア一覧に表示するための設定ファイルです。

## アンインストール方法

USBメモリをフォーマットするか、スクリプト等をフォルダごと削除してください。

## Smart Screenについて

~~特に署名とかしていませんので、zipをダウンロードして展開したbatを実行しようとするとWindowsのsmart screenに引っかかるようです。~~

curlコマンドでダウンロードしたzipファイルはSmart Screenの対象外になる模様(~~それでいいのかMSよ…~~)

## 使用ソフトウェア等

### Alpine Linux

軽量化を重視したLinuxデストリビューションです。有名なLinuxデストリビューションのインストールにはどれもたいてい数時間かかりますが、Alpine Linuxは数分で終わります。

また、対話形式のほかに設定ファイルやコマンドラインでインストールに必要なオプションの指定ができるので自動インストールもやりやすいです(他のデストリビューションでもやろうと思えばできるのかもしれませんが)

### Qemu

Windows上でLinuxを動作させるための仮想化ソフト・PCエミュレータです。各種アクセラレーションをoffにすれば管理者権限不要でも仮想化が可能になっています。

### 7-zip

Qemuはなぜか管理者権限が必要なインストーラー形式(NSIS)でしか配布していないので、管理者権限を使わず展開するために使用します。

こちらも管理者権限が必要なexe形式とmsi形式しか配布していませんが、msi形式のほうはmsiexecの管理者モード(PCが大量にある環境用にインストール作業を行うexeファイルとインストールするファイル群を分離する機能)を使えば管理者権限なしでコマンドライン上で展開できることが分かったのでこっちを使用することにしました。

### Universal Extractor 2 (現在は使っていません)

~~Qemuはなぜか管理者権限が必要なインストーラー形式でしか配布していないので、管理者権限を使わず展開するために使用します。~~

~~実際は内部で7-zipを使っているので7-zipでいいじゃないかとなりそうですが、7-zipも管理者権限が必要なインストーラー形式でしか配布していないようなので、結局zip形式で配布しているこれを使います。~~

### TeraTerm

SSH/Telnet対応のターミナルソフトウェアです。このソフトウェアのマクロ機能を積極的に用いて自動セットアップを実現しています。

### Docker CLI / Docker-Compose(Windows版)

WindowsホストからDockerコマンドを実行するのに使います。Docker CLIは公式では自分でビルドする必要がありますが、(Chocolatey向けに？)ビルド済みバイナリを公開している人がいるのでそれをダウンロードします。Docker-Composeは公式でビルド済みバイナリが公開されています。

### PortableGit(Git for Windows)

gitをWindowsで使うためのプログラム群です。gitはもちろん、unix系コマンドが大量に入っておりWindowsで使えるようになるので便利です。インストールではダウンロード用にcurl~~とzipファイルの展開用にunzip~~(githubからダウンロードしたスクリプトzipを除き7-zipで展開するようにしました)を使っています。インストール後のbashの使用にも対応しました。

### cUrl

上記の各種ソフトウェアのダウンロードに使います。最近のWindows10には標準で入っていますが、PortableGitのダウンロード以外ではPortableGitの方を使います。

### tar 

~~ダウンロード後のzipファイルの展開に使います(なぜかWindows10標準のtarはzipファイルの展開ができます、そのかわりunzipはありません)。最近のWindows10には標準で入っています。~~
githubからダウンロードしたスクリプトzipの展開に使っています、それ以外は7-zipで展開します。

### SSHクライアント

セットアップ完了後のLinuxの操作・コマンド送信に使います。最近のWindows10には標準で入っていますが、デフォルトではPortableGitに入っている方を使うように設定されています。

## このスクリプトでLinuxにインストールされるソフトウェア・コンテナ

### Docker・Docker-compose

Dockerです。これをポータブルに動かすためのスクリプトなのでこれがないと始まりません。

### Perl

後述のwebminを動作させるために必要なのでインストールされています。

### bash (現在はインストールしません)

~~後述のdocker exposeプラグインの実体はbashスクリプトなのでインストールされています。~~
docker exposeプラグインをインストールしなくなったのでこれもインストールしません。

### Portainer(portainer/portainer-ce)

ホストのDockerをwebブラウザ上で管理できるDockerコンテナです。windows上のwebブラウザから```http://localhost:9000```でアクセスできます。
ユーザー名、パスワードは初回起動時に設定する仕様になっています。
初回にエンドポイントの選択でDockerを選ぶ必要がありますが、たまに上手くいかないときがあるようなのでその場合は```10.0.2.15:2375```をURLに指定してDockerエンドポイントを作成します。

### webdav(bytemark/webdav)

webdavサーバーを実現するDockerコンテナです。windowsエクスプローラーからは```\\localhost@80\DavWWWRoot```、windows上のwebブラウザからは```http://localhost/```でアクセスできます。ホストのAlpine Linuxの/rootディレクトリ以下をWindows上から操作できます。利便性のため認証なしの匿名アクセスを許可する設定になっています。

### webmin

webブラウザで動くLinux管理ツールです。windows上のwebブラウザからは```http://localhost:10000/```でアクセスできます。ユーザー名はadmin、パスワードは無しに設定されています。正直なところいろいろ不安定なんですが、代替がないようなので…

###  docker exposeプラグイン(現在はインストールしません)

~~[ngrok](https://ngrok.com/docs)というサービスを利用して本来外部から接続できない環境下でコンテナ上のサーバーをインターネット上に公開できるようにするDocker CLIプラグインです。使い方は[ここ](https://qiita.com/tksarah/items/9e46d131107d3e15f7bc)を参照してください。~~
わざわざこういうのを入れなくても必要なら素のngrok入れればいいんじゃないかと思ったのでインストールしないようにしました。

## セキュリティ

USBメモリを刺してQemuを起動している間だけしか動作しないかつ通常はWindowsファイアウォールやルーターの関係で外部PCからの接続は困難なため(一応デフォルトでは127.0.0.1からの接続のみポートフォワーディングする設定にしてありますが)、あえてセキュリティよりも利便性を最優先にした構成になっています。
公開サーバーでは絶対にありえない構成であることは認識しておいてください、またUSBメモリの紛失盗難にも気を付けてください。

## ライセンス

[NYSL](http://www.kmonos.net/nysl/)です。
