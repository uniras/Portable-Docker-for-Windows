#!/bin/sh

#webmin variables.
WEBMIN_VERSION=1.960
WEBMIN_PORT=10000
WEBMIN_USERNAME=admin
WEBMIN_PASSWORD=admin

#Enable root login.
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

#Enable empty password login.
echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config

#Change repositories file.
mv /etc/apk/repositories /etc/apk/repositories-orig
echo '#/media/cdrom/apks' > /etc/apk/repositories
echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

#Install Docker, Docker-Compose and webmin must packages. 
apk update
apk add docker docker-compose curl perl

#Enable connection from Docker CLI for Windows.
mkdir /etc/docker/
echo '{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}' > /etc/docker/daemon.json

#Enable docker at startup.
service docker start
rc-update add docker boot

#Install Portainer.
docker volume create portainer_data
docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

set -e

#Download webmin.
echo Downloading webmin-${WEBMIN_VERSION}.tar.gz...
curl -sL https://prdownloads.sourceforge.net/webadmin/webmin-${WEBMIN_VERSION}.tar.gz \
     -o webmin-${WEBMIN_VERSION}.tar.gz

#Extract webmin.
echo Extracting webmin...
tar zxf webmin-${WEBMIN_VERSION}.tar.gz -C /var/lib/
mv /var/lib/webmin-${WEBMIN_VERSION} /var/lib/webmin
rm -rf webmin-${WEBMIN_VERSION}.tar.gz
cd /var/lib/webmin

#Execute Setup Script.
cat << EOG | ./setup.sh
/etc/webmin
/var/log/webmin
/usr/bin/perl
${WEBMIN_PORT}
${WEBMIN_USERNAME}
${WEBMIN_PASSWORD}
${WEBMIN_PASSWORD}
y
EOG

#Write Shellscript Files.
cat << EOG > /etc/init.d/webmin
#!/sbin/openrc-run
WEBMIN=/etc/webmin
start() { \${WEBMIN}/start; }
stop() { \${WEBMIN}/stop; }
EOG

#Setting Startup.
chmod a+x /etc/init.d/webmin

rc-update add webmin boot
