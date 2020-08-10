echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config

mv /etc/apk/repositories /etc/apk/repositories-orig
echo '#/media/cdrom/apks' > /etc/apk/repositories
echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

apk update
apk add docker docker-compose

mkdir /etc/docker/
echo '{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}' > /etc/docker/daemon.json

rc-update add docker boot
