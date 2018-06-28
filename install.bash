#!/bin/bash

# Most of code credit for determining version is here: https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
VER=$(curl --silent "https://api.github.com/repos/go-gitea/gitea/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'    |                               # Pluck JSON value
    sed 's|[v,]||g' )                                               # Remove v

while [[ $# -gt 0 ]]
do
  key="$1"

  case $key in
    -v|version)
    VER="$2"
    shift # past argument
    ;;
    *)
    # unknown option
    if test -z "${unknown}"
    then
      unknown=$1
    else
      echo "Unknown Option"
      exit 1
    fi
    ;;
  esac
  shift # past argument or value
done

# Create a 'gitea' user and group with the home /opt/gitea, no password (because it's a system user) and no GECOS
sudo adduser gitea --home /opt/gitea --disabled-password --gecos ''

# Make some other potentially useful directories for that user/group
sudo mkdir -p /opt/gitea/ /var/log/gitea

# Download and install gitea

  # Check if architecure is i386 and download Gitea
if [ -n "$(uname -a | grep i386)" ]; then
    sudo curl -fsSL -o "/opt/gitea/gitea-$VER" "https://dl.gitea.io/gitea/$VER/gitea-$VER-linux-386"
fi

  # Check if architecure is x86 and download Gitea
if [ -n "$(uname -a | grep x86_64)" ]; then
  sudo curl -fsSL -o "/opt/gitea/gitea-$VER" "https://dl.gitea.io/gitea/$VER/gitea-$VER-linux-amd64"
fi

# Check if architecure is ARMv6 and download Gitea
if [ -n "$(uname -a | grep armv6l)" ]; then
sudo curl -fsSL -o "/opt/gitea/gitea-$VER" "https://dl.gitea.io/gitea/$VER/gitea-$VER-linux-arm-6"
fi

  # Check if architecure is ARMv7 and download Gitea
if [ -n "$(uname -a | grep armv7l)" ]; then
  sudo curl -fsSL -o "/opt/gitea/gitea-$VER" "https://dl.gitea.io/gitea/$VER/gitea-$VER-linux-arm-7"
fi

# Setup Gitea symlink and permissions

sudo chmod +x /opt/gitea/gitea-$VER
rm -f /opt/gitea/gitea
ln -sf gitea-$VER /opt/gitea/gitea
sudo chown -R gitea:gitea /opt/gitea/ /var/log/gitea



# Download and install the gitea.service for systemd
sudo curl -fsSL -o /etc/systemd/system/gitea.service https://git.coolaj86.com/coolaj86/gitea-installer.sh/raw/branch/master/dist/etc/systemd/system/gitea.service

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
