#!/bin/bash

# wget -O install-gitea.bash https://git.coolaj86.com/coolaj86/gitea-installer/raw/master/install.bash; bash install-gitea.bash
# or
# wget -O - https://git.coolaj86.com/coolaj86/gitea-installer/raw/master/install.bash | bash

# Create a 'gitea' user and group with the home /opt/gitea, no password (because it's a system user) and no GECOS
sudo adduser gitea --home /opt/gitea --disabled-password --gecos ''

# Make some other potentially useful directories for that user/group
sudo mkdir -p /opt/gitea/ /var/log/gitea
sudo chown -R gitea:gitea /opt/gitea/ /var/log/gitea

# Download and install gitea
my_os=linux
my_arch=amd64
sys_arch="$(uname -m)"
if [ $(echo $sys_arch | grep arm7) ]; then
  my_arch=arm-7
fi
sudo wget -O /opt/gitea/gitea https://dl.gitea.io/gitea/1.0.1/gitea-1.0.1-$my_os-$my_arch
sudo chmod +x /opt/gitea/gitea

# Download and install the gitea.service for systemd
sudo wget -O /etc/systemd/system/gitea.service https://git.coolaj86.com/coolaj86/gitea-installer.sh/raw/master/dist/etc/systemd/system/gitea.service

# Start gitea
sudo systemctl restart gitea

echo "Please visit http://localhost:3000/ now to finish installing gitea"
