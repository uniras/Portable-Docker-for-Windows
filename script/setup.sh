#Enable root login.
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

#Enable empty password login.
echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config

#Change repositories file.
mv /etc/apk/repositories /etc/apk/repositories-orig
echo '#/media/cdrom/apks' > /etc/apk/repositories
echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

#Install Docker and Docker-Compose.
apk update
apk add docker docker-compose

#Enable connection from Docker CLI for Windows.
mkdir /etc/docker/
echo '{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}' > /etc/docker/daemon.json

#Enable docker at startup.
rc-update add docker boot
