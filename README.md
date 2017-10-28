# Gitea Installer

Installs Gitea as a systemd service

## Linux Install Script

You can download and run the installer script:

```bash
wget -O install-gitea.bash https://git.coolaj86.com/coolaj86/gitea-installer/raw/master/install.bash
bash install-gitea.bash
```

Or manually install by reading these instructions and following along:

```bash
# Create a 'gitea' user and group with the home /opt/gitea, no password (because it's a system user) and no GECOS
sudo adduser gitea --home /opt/gitea --disabled-password --gecos ''

# Make some other potentially useful directories for that user/group
sudo mkdir -p /opt/gitea/ /var/log/gitea
sudo chown -R gitea:gitea /opt/gitea/ /var/log/gitea

# Download and install gitea
sudo wget -O /opt/gitea/gitea https://dl.gitea.io/gitea/1.0.1/gitea-1.0.1-linux-amd64
sudo chmod +x /opt/gitea/gitea

# Download and install the gitea.service for systemd
sudo wget -O /etc/systemd/system/gitea.service https://git.coolaj86.com/coolaj86/gitea-installer/raw/master/dist/etc/systemd/system/gitea.service

# Start gitea
sudo systemctl restart gitea
```

## Gitea Web Setup (post install)

Once you've gitea installed and running you must choose
which database to use, certain gitea paths, an admin user, etc.

> http://localhost:3000/

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

## Expect user 'foobar' but current user is: gitea

```
remote: 2017/10/25 23:53:10 [...s/setting/setting.go:625 NewContext()] [E] Expect user 'aj' but current user is: gitea
remote: error: hook declined to update refs/heads/master
To ssh://git.coolaj86.com:22042/coolaj86/hexdump.js.git
 ! [remote rejected] master -> master (hook declined)
error: failed to push some refs to 'ssh://gitea@git.coolaj86.com:22042/coolaj86/hexdump.js.git'
```

If you copied a previous installation of gitea over to a new user, you may get this error.

I haven't yet found where it comes from, but deleting the repository in the UI and re-adding it seems to do the trick
from what I can tell. Remember to `git fetch --all` first before deleting.

## 203/EXEC

The downloaded gitea file is not executable

```
Oct 28 00:06:19 git-ldsconnect systemd[1]: gitea.service: Main process exited, code=exited, status=203/EXEC
Oct 28 00:06:19 git-ldsconnect systemd[1]: gitea.service: Unit entered failed state.
Oct 28 00:06:19 git-ldsconnect systemd[1]: gitea.service: Failed with result 'exit-code'.
```

Try this:

```bash
sudo chmod +x /opt/gitea/gitea

sudo systemctl restart gitea
```