+++
author = ""
comments = true
date = "2013-04-17T00:53:00+02:00"
draft = false
image = ""
menu = ""
share = true
slug = "reinstalling-all-packages-in-arch-linux"
tags = ["arch linux", "pacman", "raspberry pi"]
title = "Reinstalling all packages in Arch Linux"

+++

I've been a Gentoo user for years and just recently switched to Arch Linux as my distribution of choice. Since Gentoo is a source based distribution I found that it usually was a good idea to reinstall the packages on the base system.

Even though Arch Linux is not a source distribution I personally still like to reinstall all packages just to make sure all is well. By combining some of the tips and tricks listed at the wiki page [Pacman Tips](https://wiki.archlinux.org/index.php/Pacman_Tips#Reinstalling_all_installed_packages) you could achieve this.

When installing a package on Arch Linux with pacman, the installed package is marked in the package database as explicitly installed. The dependencies of that package are also installed but marked as being dependencies. This means that if you reinstall all packages with

    # pacman -S `pacman -Qq`

all packages will be marked as explicitly installed. But issuing

    # pacman -S `pacman -Qeq`

will only reinstall the explicitly installed packages and not any of the dependencies. 	To reinstall the dependencies the solution is to use comm as in

    # pacman -S --asdep `comm -23 <(pacman -Qq|sort) <(pacman -Qeq|sort)`

This command reinstalls all packages that are not marked as explicitly installed as dependencies (--asdep).

Now that the dependencies have been reinstalled as dependencies, it's time to reinstall the explicitly installed

    # pacman -S `pacman -Qeq`

I've used this solution for the Rackspace'd Arch Linux, my Raspberry Pi (archlinux-hf-2013-02-11.img), and Arch Linux in VirtualBox, but I think that the above commands can be used on any Arch Linux installation to keep the integrity of the package database when reinstalling all packages.
