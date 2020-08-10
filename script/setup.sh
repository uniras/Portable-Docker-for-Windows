#root、パスワードなしでSSHログインできるようにconfigを追記
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config

#docker docker-compseをインストールするためオリジナルのファイルの退避とレポジトリファイルの作成
mv /etc/apk/repositories /etc/apk/repositories-orig
echo '#/media/cdrom/apks' > /etc/apk/repositories
echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

#docker docker-composeをインストール
apk update
apk add docker docker-compose

#Windowsホスト側のDocker CLIからアクセスできるように設定ファイルの作成
mkdir /etc/docker/
echo '{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}' > /etc/docker/daemon.json

#起動時にDockerデーモンが自動的に起動するように設定
rc-update add docker boot
