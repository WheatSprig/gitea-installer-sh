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
sudo wget -O /etc/systemd/system/gitea.service https://git.coolaj86.com/coolaj86/gitea-installer/raw/master/README.md

# Start gitea
sudo systemctl restart gitea
```

# Troubleshooting

## Error 226/Namespace

Most likely a directory that is supposed to be writable doesn't exist.

## Failed to get repository owner (foobar): no such table: user

Your `custom/conf/app.ini` has a line like this:

```
[database]
DB_TYPE = sqlite3
PATH = data/gitea.db
```

And it should probably look like this instead:

```
[database]
DB_TYPE = sqlite3
PATH = /opt/gitea/data/gitea.db
```

## Gitea: Invalid key ID

```
Gitea: Invalid key ID
Invalid key ID[key-2]: public key does not exist [id: 2]
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
```

You are connecting to gitea with a different ssh key (usually `id_rsa.pub`)
than the one you uploaded. You can usually fix this by uploading your default key
or by manually specifying which key to use, for example:

`~/.ssh/config`:
```
Host git.example.com
  User gitea
  IdentityFile ~/.ssh/id_rsa
```
