# Gitea Uninstall Script
# This script removes Gitea as installed by this script. THIS DELTES ALL DATA if you are using SQLite.

echo "Removing Gitea and DELETING ALL DATA."

sudo systemctl stop gitea # Stop the Gitea service
sudo systemctl disable gitea # Disable the Gitea service automatically starting on boot.
sudo rm /etc/systemd/system/gitea.service # Delete the Gitea service.
sudo rm /usr/local/bin/gitea # Remove Gitea from Path
sudo rm -rf /opt/gitea # Remove Gitea Data

echo "Done."
