+++
author = ""
comments = true
date = "2014-02-14T13:54:00"
draft = false
image = ""
menu = ""
share = true
slug = "all-simple-with-getsimple"
tags = ["getsimple", "nginx", "raspberry pi"]
title = "All simple with GetSimple"

+++

In moving my personal site from a Rackspace Cloud Server to a Raspberry Pi I was looking for a lightweight substitution for the earlier used CMS [concrete5](http://www.concrete5.org/). I found [GetSimple CMS](http://get-simple.info/):

> GetSimple is an XML based, stand-a-alone, fully independant and lite Content Management System. To go along with its best-in-class user interface, we have loaded it with features that every website needs, but with nothing it doesn't. GetSimple is truly the simplest way to manage a small-business website. ~ [About GetSimple](http://get-simple.info/start/)

concrete5 is by no means a bad CMS, but its need of a database and the many features that I have no use for, but that effect overall performance, does not match well with the technical specifications of the Raspberry Pi. The switch of web server, from Apache to nginx, is also in respect to the performance issues.

A small drawback with GetSimple is that it doesn't support nginx out of the box, but there's a solution presented by marrco at the [GetSimple Forum](http://get-simple.info/forums/showthread.php?tid=1269). Another great write-up is [A lightweight CMS for your Raspberry Pi webserver](http://www.janteichmann.me/projects/raspberrypi_webserver#cms) by Jan Teichmann.

In summary; I'm really impressed by the GetSimple CMS!
