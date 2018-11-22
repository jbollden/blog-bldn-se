+++
author = ""
comments = true
date = "2016-04-24T17:18:00+02:00"
draft = false
image = ""
menu = ""
share = true
slug = "ghost-on-nginx-with-lets-encrypt-certificate"
tags = ["ghost", "nginx", "ssl", "web"]
title = "Ghost on Nginx with Let's Encrypt certificate"

+++

I wanted to secure my Nginx web server with the use of this new free service [Let's Encrypt](https://letsencrypt.org/) and the people over at [DigitalOcean](https://www.digitalocean.com/) are always busy making sure there's a lot of great tutorials for the rest of us.

Following the instructions in "[How To Secure Nginx with Let's Encrypt on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-secure-nginx-with-let-s-encrypt-on-ubuntu-14-04)" has nos given me HTTPS-capabilities.

This blog is, at the time of writing, running on [Ghost](https://ghost.org/), an awesome node.js-based blog engine, proxied by Nginx. I found that to get SSL-support for it all I really needed to do was:

1. Disable the proxy for Ghost, e.g. comment out that block in the Nginx configuration
2. Follow the instructions in the post mentioned above 
3. Enable the proxy instructions again
4. Reload Nginx
