# Gitea Installer

Installs [Gitea](https://gitea.io) (formerly gogs) as a systemd service

## Linux Install Script

You can download and run the installer script:

```bash
wget -O install-gitea.bash https://git.coolaj86.com/coolaj86/gitea-installer.sh/raw/master/install.bash
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
sudo wget -O /etc/systemd/system/gitea.service https://git.coolaj86.com/coolaj86/gitea-installer.sh/raw/master/dist/etc/systemd/system/gitea.service

# Start gitea
sudo systemctl restart gitea
```

## Gitea Web Setup (post install)

Once you've gitea installed and running you must choose
which database to use, certain gitea paths, an admin user, etc.

> http://localhost:3000/

## Customize Gitea

```
/opt/gitea/custom/conf/app.ini

https://github.com/go-gitea/gitea/tree/master/custom/conf/app.ini.sample
```

## Customize Gitea Theme

All overrides to the existing theme can be placed in the `custom/public` and `custom/templates` folders.

* Change Logo
* Change Landing Page
* Google Analytics


```
/opt/gitea/custom/public
/opt/gitea/custom/templates

/opt/gitea/custom/public/img/favicon.png     # 16x16 logo in tab
/opt/gitea/custom/public/img/gitea-sm.png    # 120x120 logo on all pages
/opt/gitea/custom/public/img/gitea-sm.png    # 880x880 logo on landing page

/opt/gitea/custom/templates/home.tmpl        # The landing page
/opt/gitea/custom/templates/base/head.tmpl   # Google Analytics
```

For many items, such as the logo, you can simply right-click "inspect" to discover the location. For example, the small logo is `/img/gitea-sm.png` or `/opt/gitea/custom/public/img/gitea-sm.png`.

You can find more information about customization and templates in the docs and on github:

* https://docs.gitea.io/en-us/customizing-gitea/
* https://github.com/go-gitea/gitea/tree/master/templates/
# Troubleshooting systemd

See [Troubleshooting systemd](https://git.coolaj86.com/coolaj86/service-installer.sh/src/master/README.md#troubleshooting-systemd)