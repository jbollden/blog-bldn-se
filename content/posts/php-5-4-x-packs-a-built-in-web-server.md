+++
author = ""
comments = true
date = "2012-09-02T21:42:00+02:00"
draft = false
image = ""
menu = ""
share = true
slug = "php-5-4-x-packs-a-built-in-web-server"
tags = ["php", "web"]
title = "PHP 5.4.x packs a built-in web server"

+++

New in PHP from version 5.4.x is a built-in web server perfect for use during development. By issuing the following command in a terminal you will be able to serve the content in ~/public_html over port 8080:

    $ php -S 0.0.0.0:8080 -t ~/public_html

A more comprehensive article on the subject can be found at the php.net-site: [Built-in web server](http://php.net/manual/en/features.commandline.webserver.php).

On a side note you should remember that the built-in server is PHP specific, i.e. functionality like e.g.. the Apache .htaccess-file will not work since the built-in server isn't an Apache server.
