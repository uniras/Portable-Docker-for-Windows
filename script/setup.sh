#!/bin/sh

#Enable root login.
echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config

#Enable empty password login.
echo 'PermitEmptyPasswords yes' >> /etc/ssh/sshd_config

#Change repositories file.
mv /etc/apk/repositories /etc/apk/repositories-orig
echo '#/media/cdrom/apks' > /etc/apk/repositories
echo 'http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories
echo 'http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

#Install Docker, Docker-Compose, webmin and Docker Expose Plugin must packages. 
apk update
apk add docker docker-compose curl perl bash

#Enable connection from Docker CLI for Windows.
mkdir /etc/docker/
echo '{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}' > /etc/docker/daemon.json

#Enable docker at startup.
service docker start
rc-update add docker boot

#Waiting docker start.
sleep 10

#Install Portainer.
docker volume create portainer_data
docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce

#Install Webdav Server
docker run -d -p 80:80 --name webdav --restart=always -e AUTH_TYPE=Digest -e USERNAME=user -e PASSWORD=abcdefg -e ANONYMOUS_METHODS=ALL -v /root:/var/lib/dav/data bytemark/webdav

#Download webmin.
echo Downloading webmin-%WEBMIN_VERSION%.tar.gz...
curl -sL https://prdownloads.sourceforge.net/webadmin/webmin-%WEBMIN_VERSION%.tar.gz \
     -o webmin-%WEBMIN_VERSION%.tar.gz

#Extract webmin.
echo Extracting webmin...
tar zxf webmin-%WEBMIN_VERSION%.tar.gz -C /var/lib/
mv /var/lib/webmin-%WEBMIN_VERSION% /var/lib/webmin
rm -rf webmin-%WEBMIN_VERSION%.tar.gz
cd /var/lib/webmin

#Execute Setup Script.
cat << EOF | ./setup.sh
/etc/webmin
/var/log/webmin
/usr/bin/perl
10000
admin


y
EOF

#Write Startup Shellscript Files.
cat << EOF > /etc/init.d/webmin
#!/sbin/openrc-run
start() { /etc/webmin/start; }
stop() { /etc/webmin/stop; }
EOF

#Setting Startup.
chmod a+x /etc/init.d/webmin

rc-update add webmin boot

#Download and Install Docker Expose Plugin
mkdir -p ~/.docker/cli-plugins

curl -sf %DOCKER_EXPOSE_PLUGIN_URL% -o ~/.docker/cli-plugins/docker-clip

chmod +x ~/.docker/cli-plugins/docker-clip
