# Gitea Uninstall Script
# This script removes Gitea as installed by this script. THIS DELTES ALL DATA if you are using SQLite.

echo "Removing Gitea and DELETING ALL DATA."

echo "Stopping and removing the Gitea service."
sudo systemctl stop gitea # Stop the Gitea service
sudo systemctl disable gitea # Disable the Gitea service automatically starting on boot.
sudo rm /etc/systemd/system/gitea.service # Delete the Gitea service.

echo "Deleting Gitea configuration and Data."

sudo rm /usr/local/bin/gitea # Remove Gitea from Path
sudo rm -rf /opt/gitea # Remove Gitea Data

if test ! -d /opt/gitea
   echo "Gitea has been completely removed."
else
  echo "Gitea has not been completely removed. File an issue here: https://git.coolaj86.com/coolaj86/gitea-installer.sh/issues/new"
