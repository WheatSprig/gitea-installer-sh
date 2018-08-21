# Gitea Installer

Installs [Gitea](https://gitea.io) (formerly Gogs) as a systemd service

# Easy Install (Linux)

You can download and run the installer script using this command:

`curl -fsSL https://git.coolaj86.com/coolaj86/gitea-installer.sh/raw/branch/master/install.bash | bash`

<a href="https://youtu.be/dTvTBlzKqgg" target="_blank"><img title="How to install Gitea" alt="a screencast of me installing gitea and migrating one of my github repos" src="https://i.imgur.com/e4CZdBu.png"></a>

## Specific Versions

You can pick a specific version to install. For example, if you were nostalgic for 1.2.0, you could run:

`curl -fsSL https://git.coolaj86.com/coolaj86/gitea-installer.sh/raw/branch/master/install.bash | bash -s version 1.2.0`

# After Installing

Once you have gitea installed and running you must choose
which database to use, certain gitea paths, an admin user, etc.

Go to: http://localhost:3000/

You should see these fields:

*The following is for basic usage with this script, for more advance usage see: [https://docs.gitea.io/en-us/customizing-gitea/](https://docs.gitea.io/en-us/customizing-gitea/)*

`Database Type:` Use SQLite3 for the database.

`Path:` Leave this alone.

`Application Name:` Give your Gitea server a fancy name.

`Repository Root Path:` Leave this alone.

`LFS Root Path:` Leave this alone.

`Run User:` Leave this alone.

`Domain:` Replace this with your domain name for the server.

`SSH Port:` Leave this alone unless you want a custom port for SSH.

`HTTP Port:` Change this if you want Gitea to serve on a different port. You don't usually need to, Gitea is usually used behind a web server.

`Application URL:` Enter the full URL for your Gitea instance, like https://example.com/

`Log Path:` Leave this alone.

Click on "Admin Account Settings" to setup your user account and click "Install Gitea" when you are done.

## Manual Install

Or manually install by reading these instructions and following along:

```bash
### Create a 'gitea' user and group with the home /opt/gitea, no password (because it's a system user) and no GECOS
sudo adduser gitea --home /opt/gitea --disabled-password --gecos ''

### Make some other potentially useful directories for that user/group
sudo mkdir -p /opt/gitea/ /var/log/gitea
sudo chown -R gitea:gitea /opt/gitea/ /var/log/gitea

### Download and install gitea. Replace "amd64" with "i386" for 32 bit x86 or "arm-7" for ARMv7 and "arm-6" for ARMv6.
sudo wget -O /opt/gitea/gitea https://dl.gitea.io/gitea/1.4.1/gitea-1.4.1-linux-amd64
sudo chmod +x /opt/gitea/gitea

### Download and install the gitea.service for systemd
sudo wget -O /etc/systemd/system/gitea.service https://git.coolaj86.com/coolaj86/gitea-installer.sh/raw/master/dist/etc/systemd/system/gitea.service

### Start gitea
sudo systemctl restart gitea
```

Then see the post-install instruction above.

## Customize Gitea

```
/opt/gitea/custom/conf/app.ini

https://github.com/go-gitea/gitea/tree/master/custom/conf/app.ini.sample
```

Once a reverse proxy is set up you can change the `HTTP_ADDR` from the default (world accessible) to localhost-only.

```
HTTP_ADDR        = localhost
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
/opt/gitea/custom/templates/base/head.tmpl   # Google Analytics, Login with Github
```

* [Login with Github](https://git.coolaj86.com/coolaj86/gitea-installer.sh/src/tag/v1.0.0/custom/templates/base/head.tmpl#L277)

For many items, such as the logo, you can simply right-click "inspect" to discover the location. For example, the small logo is `/img/gitea-sm.png` or `/opt/gitea/custom/public/img/gitea-sm.png`.

You can find more information about customization and templates in the docs and on github:

* https://docs.gitea.io/en-us/customizing-gitea/
* https://github.com/go-gitea/gitea/tree/master/templates/

# Troubleshooting systemd

See [Troubleshooting systemd](https://git.coolaj86.com/coolaj86/service-installer.sh/src/master/README.md#troubleshooting-systemd)

# Removing Gitea

Run this command to uninstall Gitea: (THIS WILL REMOVE ALL DATA if you are using SQLite!)

`curl -fsSL https://git.coolaj86.com/coolaj86/gitea-installer.sh/raw/branch/master/remove.bash | bash`
