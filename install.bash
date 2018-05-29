#!/bin/bash

VER=1.4.1

# wget -O install-gitea.bash https://git.coolaj86.com/coolaj86/gitea-installer/raw/master/install.bash; bash install-gitea.bash
# or
# wget -O - https://git.coolaj86.com/coolaj86/gitea-installer/raw/master/install.bash | bash

# Create a 'gitea' user and group with the home /opt/gitea, no password (because it's a system user) and no GECOS
sudo adduser gitea --home /opt/gitea --disabled-password --gecos ''

# Make some other potentially useful directories for that user/group
sudo mkdir -p /opt/gitea/ /var/log/gitea
sudo chown -R gitea:gitea /opt/gitea/ /var/log/gitea

# Download and install gitea
sudo wget -O "/opt/gitea/gitea-$VER" "https://dl.gitea.io/gitea/$VER/gitea-$VER-linux-amd64"
sudo chmod +x /opt/gitea/gitea-$VER
rm -f /opt/gitea/gitea
ln -sf gitea-$VER /opt/gitea/gitea

# Download and install the gitea.service for systemd
sudo wget -O /etc/systemd/system/gitea.service https://git.coolaj86.com/coolaj86/gitea-installer.sh/raw/master/dist/etc/systemd/system/gitea.service

# Start gitea
sudo systemctl enable gitea

## If this is performing an upgrade it may need extra ram for a limited time
# fallocate -l 1G /tmp.swap
# mkswap /tmp.swap
# chmod 0600 /tmp.swap
# swapon /tmp.swap
sudo systemctl restart gitea

echo ""
echo "Please visit http://localhost:3000/ now to finish installing gitea"
echo ""
echo "You may customize gitea"
echo "    templates can be seen at https://github.com/go-gitea/gitea/tree/v$VER/templates"
echo "    app.ini.sample can be seen at https://github.com/go-gitea/gitea/blob/v$VER/custom/conf/app.ini.sample"

# sleep 5
# swapoff /tmp.swap
# rm /tmp.swap