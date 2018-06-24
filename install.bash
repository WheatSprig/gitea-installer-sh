#!/bin/bash

VER=1.4.2

# wget -O install-gitea.bash https://git.coolaj86.com/coolaj86/gitea-installer/raw/master/install.bash; bash install-gitea.bash
# or
# wget -O - https://git.coolaj86.com/coolaj86/gitea-installer/raw/master/install.bash | bash

# Create a 'gitea' user and group with the home /opt/gitea, no password (because it's a system user) and no GECOS
sudo adduser gitea --home /opt/gitea --disabled-password --gecos ''

# Make some other potentially useful directories for that user/group
sudo mkdir -p /opt/gitea/ /var/log/gitea
sudo chown -R gitea:gitea /opt/gitea/ /var/log/gitea

# Download and install gitea

  # Check if architecure is i386 and download Gitea
if [ -n "$(uname -a | grep i386)" ]; then
  sudo wget -O "/opt/gitea/gitea-$VER" "https://dl.gitea.io/gitea/$VER/gitea-$VER-linux-386"
fi

  # Check if architecure is x86 and download Gitea
if [ -n "$(uname -a | grep x86_64)" ]; then
  sudo wget -O "/opt/gitea/gitea-$VER" "https://dl.gitea.io/gitea/$VER/gitea-$VER-linux-amd64"
fi

# Check if architecure is ARMv6 and download Gitea
if [ -n "$(uname -a | grep armv6l)" ]; then
sudo wget -O "/opt/gitea/gitea-$VER" "https://dl.gitea.io/gitea/$VER/gitea-$VER-linux-arm-6"
fi

  # Check if architecure is ARMv7 and download Gitea
if [ -n "$(uname -a | grep armv7l)" ]; then
  sudo wget -O "/opt/gitea/gitea-$VER" "https://dl.gitea.io/gitea/$VER/gitea-$VER-linux-arm-7"
fi

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

set +e
my_ip=$(ifconfig | grep inet | grep Mask | grep -v ':127\\.0\\.0\\.1' | grep -v ':192\\.168'  | grep -v ':10\\.' | head -n 1 | cut -f 2 -d ':' | cut -f 1 -d ' ')
my_ip=${my_ip:-localhost}
set -e

echo ""
echo ""
echo "###########################"
echo "#    Time to Configure    #"
echo "###########################"
echo ""
echo "Just a few more steps to complete at the setup URL:"
echo ""
echo "        http://$my_ip:3000/"
echo ""
echo "Future changes can be made by editing the config file:"
echo ""
echo "        /opt/gitea/custom/conf/app.ini"
echo ""
echo ""
echo "P.S. Would you like to customize Gitea?"
echo ""
echo "        Read basic instructions:"
echo "        https://git.coolaj86.com/coolaj86/gitea-installer.sh/_edit/master/install.bash"
echo ""
echo "        View current templates:"
echo "        https://github.com/go-gitea/gitea/tree/v$VER/templates"
echo ""
echo "        See a sample app.ini:"
echo "        https://github.com/go-gitea/gitea/blob/v$VER/custom/conf/app.ini.sample"
echo ""

# sleep 5
# swapoff /tmp.swap
# rm /tmp.swap
