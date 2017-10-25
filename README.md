# Gitea Installer

Installs Gitea as a systemd service

# Linux

Just follow these instructions:

```bash
# Create a 'gitea' user and group with the home /opt/gitea
sudo adduser gitea --home /opt/gitea

# Make some other potentially useful directories for that user/group
sudo mkdir -p /opt/gitea/ /var/log/gitea /srv/gitea
sudo chown -R gitea:gitea /opt/gitea/ /var/log/gitea /srv/gitea

# Download and install gitea
sudo wget -O /opt/gitea/gitea https://dl.gitea.io/gitea/1.0.1/gitea-1.0.1-linux-amd64
sudo chmod +x gitea

# Download and install the gitea.service for systemd
sudo wget -O /etc/systemd/system/gitea.service https://git.coolaj86.com/coolaj86/gitea-installer/src/master/dist/etc/systemd/system/gitea.service

# Start gitea
sudo systemctl restart gitea
```

# Troubleshooting

## Error 226/Namespace

Most likely a directory that is supposed to be writable doesn't exist.
