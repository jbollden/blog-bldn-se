+++
author = ""
comments = true
date = "2013-06-07T07:51:00+02:00"
draft = false
image = ""
menu = ""
share = true
slug = "updating-arch-2013-2-on-rackspace"
tags = ["arch linux", "cloud", "rackspace"]
title = "Updating Arch 2013.2 on Rackspace"

+++

With June 3rd came an update for Arch Linux that gave me some server trouble I couldn't recover from. I had to start my Rackspace server in Rescue Mode to get my data back (files and databases). On the upside I found that Rackspace had upgraded the image to build from, now it's "Arch 2013.2". So I rebuilt the server from that image. This article describes how I upgraded the server and created a new image that could be used for creating new servers on Rackspace.

## Switch to `systemd`

Edit the GRUB boot file and add `init=/usr/lib/systemd/systemd` to the kernel line:

`# nano -w /boot/grub/menu.lst`

    kernel /boot/vmlinuz-linux root=/dev/xvda1 ro console=hvc0 init=/usr/lib/systemd/systemd

Then reboot the system:

`# reboot`

Once you've logged back in you could check that `cat /proc/1/comm` returns `systemd`, which means `systemd` is running. Before the reboot `init` would have been returned.

Next you should synchronize the package databases and upgrade `pacman`:

    # pacman -Syy pacman
    # mv /etc/pacman.conf.pacnew /etc/pacman.conf

It is recommended, but, as far as I know, not needed, to enable three components in `systemd` on your Rackspace NextGen Cloud server. Two of them is in the package `xe-guest-utilities` and the third, `nova-agent`, is already on your system.

`# pacman -S xe-guest-utilities`

Create the custom service for `nova-agent`:

`# nano -w /etc/systemd/system/nova-agent.service`

with the following content:

    [Unit]
    Description=Openstack nova agent
    After=xe-daemon.service

    [Service]
    Type=forking
    ExecStart=/usr/bin/nova-agent -q -o /var/log/nova-agent.log -l info /usr/share/nova-agent/nova-agent.py

    [Install]
    WantedBy=multi-user.target

You should move the `nova-agent` binary to `/usr/bin`:

`# mv /usr/sbin/nova-agent /usr/bin/`

Then enable the services:

    # systemctl enable xe-linux-distribution.service
    # systemctl enable xe-daemon.service
    # systemctl enable nova-agent.service

In `/etc/rc.conf` you should convert the `DAEMONS` to `systemd` services. I first switched `dcron` for `cronie`, which is the default cron service for Arch Linux:

`# pacman -S cronie`

and then enabled:

    # systemctl enable sshd.service
    # systemctl enable syslog-ng.service
    # systemctl enable cronie.service
    # systemctl enable netcfg.service

To finalize the switch to `systemd` remove `sysvinit` and `initscript`, and install `systemd-sysvcompat`:

    # pacman -R sysvinit initscripts
    # pacman -S systemd-sysvcompat

Followed by a reboot

`# reboot`

## Switch to `netctl`

This image still uses `netcfg` which in time will be deprecated, therefore it is a good idea to do the switch at the same time as the rest of the updates. This is explained in detail on the Arch Linux [wiki](https://wiki.archlinux.org/index.php/Netctl), and below I describe what I did.

First remove `netcfg` and then install `netctl`:

    # pacman -R netcfg
    # pacman -S netctl

Copy the old `netcfg`-profiles:

    # cp /etc/network.d/eth0 /etc/netctl/
    # cp /etc/network.d/eth1 /etc/netctl/

Then edit them according to [Migrating from netcfg](https://wiki.archlinux.org/index.php/Netctl#Migrating_from_netcfg).

`# nano -w /etc/netctl/eth0`

    Interface=eth0
    Connection=ethernet
    IP=static
    Address=('<public_ip>/24')
    Gateway='<gateway>'
    DNS=('83.138.151.81' '83.138.151.80')</pre>
    
`# nano -w /etc/netctl/eth1`

    Interface=eth1
    Connection=ethernet
    IP=static
    Address=('<private_ip>/18')
    DNS=('83.138.151.81' '83.138.151.80')

Then enable the profiles, followed by a reboot:

    # netctl enable eth0
    # netctl enable eth1
    # reboot

## Upgrade to the new `filesystem`

On June 3rd a [news bulletin](https://www.archlinux.org/news/binaries-move-to-usrbin-requiring-update-intervention/) came out stating that the filesystem would be changed on the next system upgrade, all binaries will now be placed in `/usr/bin`. By following the below steps you will not break your Rackspace server like I did.

First upgrade all packages, but `filesystem` and `bash`:

`# pacman -Syu --ignore filesystem,bash`

Remove obsolete packages:

`# pacman -R gen-init-cpio tcp_wrappers`

Upgrade `bash`:

`# pacman -S bash`

Move GRUB binaries and remove old directories:

    # mv `ls /bin/* /sbin/* /usr/sbin/*` /usr/bin/
    # rmdir /bin/ /sbin/ /usr/sbin/</span></pre>

Upgrade the `filesystem` package:

`# pacman -Su`

And reboot your system to make sure everything is working:

`# reboot`

## Cleaning up and creating an image

At this point you're pretty much up to date with your system, however, there are som orphan packages you probably will do without. Run this command until it responds with `error: no targets specified (use -h for help)`:

    # pacman -R `pacman -Qdtq`

It's now possible to create a server image to use for creating new servers. Perhaps you first would like to add packages and configurations you probably will do on all your following servers anyway.

I install `ntp`, `mlocate`, `screen` and `htop`, and configure `locales`, `localtime` and `bash` colours in my basic image.
