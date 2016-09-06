+++
author = ""
comments = true
date = "2015-12-03T08:44:00"
draft = false
image = ""
menu = ""
share = true
slug = "upgrading-ghost"
tags = ["ghost", "web"]
title = "Upgrading Ghost"

+++

I'm not comfortable with the upgrade procedure that's suggested on the support page "[How to Upgrade Ghost](http://support.ghost.org/how-to-upgrade/)". The following post describes my way of upgrading.

By monitoring the GitHub [page](https://github.com/TryGhost/Ghost/releases) you'll see when there's a new version released.

## Current setup
I'm running my [Ghost blog](https://ghost.org/) on a Linux Droplet at [DigitalOcean](https://www.digitalocean.com/) and use a somewhat different procedure to upgrade my Ghost blog to the latest release. The setup is on Nginx much like described in this [post](https://www.howtoinstallghost.com/how-to-host-ghost-on-a-nginx-subdomain/) with the use of [Supervisor](http://docs.ghost.org/pl/installation/deploy/#supervisor-(http://supervisord.org/)) to keep Ghost as a service.

`ls -las` in the directory where I keep the blog gives:
```
total 12
drwxr-xr-x 3 user user 4096 Oct  4 10:59 custom-ghost
lrwxrwxrwx 1 user user   11 Nov 30 08:13 ghost -> ghost-0.7.1
drwxr-xr-x 5 user user 4096 Sep  5 08:17 ghost-0.7.0
drwxr-xr-x 5 user user 4096 Oct  9 11:03 ghost-0.7.1
```
and a `tree custom-ghost` gives:
```
custom-ghost/
├── config.js
└── content
    ├── apps
    ├── data
    │   └── ghost.db
    ├── images
    └── themes
        └── casper
            ├── post.hbs
            ├── post.hbs-0.7.0
            └── post.hbs-0.7.1

6 directories, 8 files
```

`custom-ghost` holds the information I want to keep between upgrades, like the `config.js`, the database in `ghost.db` and the custom `post.hbs`[^n].

## Upgrading

The starting point for the following commands is the directory where I keep my blog.

### Backup database
Export the blog settings and data, found under the Labs menu.

### Download
```
$ wget https://github.com/TryGhost/Ghost/releases/download/0.7.2/Ghost-0.7.2.zip
```

### Unzip
```
$ unzip Ghost-0.7.2.zip -d ghost-0.7.2
```

### Update symlink
```
$ rm ghost
$ ln -s ghost-0.7.2 ghost
```

### Install
```
$ cd ghost
$ npm install --production
```

### Symlink config.js
If the there is a `config.js` it should be deleted, but it is a good idea to check if it or `config.example.js` has changed in some way (perhaps new parameters etc).
```
$ rm config.js
$ ln -s ../custom-ghost/config.js .
```

### Symlink customised files
I try to keep the original file as a backup, thus copying it to the `custom-ghost` structure.

After you've symlinked make sure to return to the `ghost`-directory.

```
$ cd content/themes/casper/
$ mv post.hbs ../../../../custom-ghost/content/themes/casper/post.hbs-0.7.2
$ ln -s ../../../../custom-ghost/content/themes/casper/post.hbs .
$ cd ../../../
```

### Start
The Supervisor needs to be stopped first, then staring Ghost with `npm`. This will give a easier way of discovering errors and warnings.

```
$ supervisorctl stop ghost
$ npm start --production
```

### Restart
Stop the `npm` with **ctrl+c**, then start Supervisor.

```
$ supervisorctl start ghost
```

[^n]: The customisation is the adding of comments field, see "[How to Add Comments to Ghost using Disqus](https://www.ghostforbeginners.com/how-to-enable-comments-on-a-ghost-blog/)".
