# Portable Docker for Windows (PDW)

Portable Docker for Windows(PDW)はWindows上でQemuを利用した管理者権限不要のポータブルなLinux及びDocker環境を自動で構築するためのスクリプト群です。

## 用意するもの

ポータブル利用するには16GB以上の比較的書き込みが高速なUSBメモリが必要です、これが遅いと書き込み速度に引っ張られて動作が遅くなります。ランダム書き込み速度が重要なのでパッケージ等で公称されている速度(大抵シーケンシャル書込速度)が高ければいいとは限りません。PCの環境にも影響するので注意しましょう。個人差はあるでしょうが、CrystalDiskmarkで右下2つのランダム書き込み速度を示す値が1.0を超えないと辛いと思います。

もちろんWindowsPCとインターネット環境は必須ですが自己所有である必要はありません。他人が管理する環境を使用する場合はルールを守りましょう。

## インストール方法

git cloneまたはzipファイルを利用したいUSBメモリに展開後、scriptフォルダ内のsetup.batをダブルクリックします。

使用するソフトウェアのダウンロードから解凍・セットアップまですべて自動で行います。

デフォルトでは仮想HDDの容量は10GBで作成されますので、足りないと思う場合はscriptフォルダにあるconfig.batのQEMU_HDD_DEF_SIZEの値を変更してください。

後で容量を増やすことはできるようですが、ちょっと面倒です。

## 使用方法

インストール後、start.batをダブルクリックするとQemuを起動します。しばらく(1～2分くらい)後にssh.batをダブルクリックしてssh接続するとssh経由でLinuxを操作することができます。

dockerconsole.batはQemuを起動し、Linuxの起動を待ってDocker CLIを使える状態でコマンドプロンプトを起動します。

halt.batはssh経由でLinuxをシャットダウンするコマンドを送信してLinux/Qemuを終了します。

## 各種スクリプトファイルの説明

ルートフォルダ
 - dockerconsole.bat　Qemuを起動し、Linuxのブートを待ってDocker CLIが使える状態でコマンドプロンプトを起動します
 - halt.bat　SSH経由でLinuxとQemuをシャットダウンします
 - ssh.bat　SSHを起動してLinuxに接続します。
 - start.bat　Qemuを起動してLinuxをブートします

scriptフォルダ
 - config.bat　各種設定を環境変数として設定しています。設定変更する場合はこのファイルを書き換えます。
 - dockerconfig.bat　Docker CLIの動作に必要な環境変数を設定します。
 - download.bat　セットアップに必要な各種ソフトウェアをダウンロードします。
 - downloadconfig.bat　ソフトウェアのURLや保存先等を環境変数として設定しています。
 - setup.bat　セットアップを開始します。すでにセットアップが終了している場合でも全て初期化して再度ダウンロード・セットアップしますので注意してください。
 - startwait.bat　TeraTermマクロを利用してLinuxがブート中の場合はLinuxのブート完了まで待機します。ブート済みの場合はすぐに終了します。
 - stopwait.bat　TeraTermマクロを利用してLinuxとQemuが正常にシャットダウンされるまで待機します。このバッチファイルは待機するだけでシャットダウンはしません。

## Smart Screenについて

特に署名とかしていませんので、zipをダウンロードして解凍したbatを実行しようとするとWindowsのsmart screenに引っかかるようです。

自分が作ったスクリプト部分は全てソース丸見えなので変なコードとかは仕込んでいませんが、気になる人は自分で解析するか手動でインストールしてください。

## 使用ソフトウェア等

### Alpine Linux

軽量化を重視したLinuxデストリビューションです。有名なLinuxデストリビューションのインストールにはどれもたいてい数時間かかりますが、Alpine Linuxは数分で終わります。

また、対話形式のほかに設定ファイルやコマンドラインでインストールに必要なオプションの指定ができるので自動インストールもやりやすいです(他のデストリビューションでもやろうと思えばできるのかもしれませんが)

### Qemu

Windows上でLinuxを動作させるための仮想化ソフト・PCエミュレータです。各種アクセラレーションをoffにすれば管理者権限不要でも仮想化が可能になっています。

### Universal Extractor 2

Qemuはなぜか管理者権限が必要なインストーラー形式でしか配布していないので、管理者権限を使わず解凍するために使用します。

実際は内部で7-zipを使っているので7-zipでいいじゃないかとなりそうですが、7-zipもインストーラー形式でしか配布していないようなので、結局zip形式で配布しているこれを使います。

### TeraTerm

SSH/Telnet対応のターミナルソフトウェアです。このソフトウェアのマクロ機能を積極的に用いて自動セットアップを実現しています。

### Docker CLI / Docker-Compose(Windows版)

WindowsホストからDockerコマンドを実行するのに使います。Docker CLIは公式では自分でビルドする必要がありますが、(Chocolatey向けに？)ビルド済みバイナリを公開している人がいるのでそれをダウンロードします。Docker-Composeは公式でビルド済みバイナリが公開されています。

### cUrl

上記の各種ソフトウェアのダウンロードに使います。最近のWindows10には標準で入っています。

### tar

ダウンロード後の各種zipファイルの解凍に使います(なぜかzipファイルの解凍にも使えます)。最近のWindows10には標準で入っています。

### SSHクライアント

セットアップ完了後のLinuxの操作・コマンド送信に使います。最近のWindows10には標準で入っています。

## セキュリティ

USBメモリを刺してQemuを起動している間だけしか動作しないかつ通常はWindowsファイアウォールやルーターの関係で外部PCからの接続は困難なため、あえてセキュリティよりも利便性を最優先にした構成になっています。
公開サーバーでは絶対にありえない構成であることは認識しておいてください、またUSBメモリの紛失盗難にも気を付けてください。
