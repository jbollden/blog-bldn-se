+++
author = ""
comments = true
date = "2013-02-23T19:10:00+02:00"
draft = false
image = ""
menu = ""
share = true
slug = "codeigniter-introduces-_serverci_env"
tags = ["apache", "codeigniter"]
title = "CodeIgniter introduces $_SERVER['CI_ENV']"

+++

On the 3rd of March last year (2012) 'roberto-butti' suggested using a server environment variable to control the value of CodeIgniter's ENVIRONMENT. The full discussion on the issue can be found at [GitHub](https://github.com/EllisLab/CodeIgniter/issues/1112). And in June Phil Sturgeon added logic for this in index.php ([see commit](https://github.com/EllisLab/CodeIgniter/commit/dda21f6abc76451997b12c07e6066aa49c2d423d#index.php)).

By using Apache's SetEnvIf-directive in .htaccess it is possible to set conditional server environment variables.

Let's say you have three different server environments; production, testing, development and they all resides on different hostnames; www.domain.tld, test.domain.tld and dev.domain.tld. Then a simple .htaccess would look something like:

    RewriteEngine On

    SetEnvIf Host www.domain.tld$ CI_ENV=production
    SetEnvIf Host test.domain.tld$ CI_ENV=testing
    SetEnvIf Host dev.domain.tld$ CI_ENV=development

Note that both mod_rewrite and mod_setenvif have to be enabled. Should all of the above conditions fail then ENVIRONMENT will fallback to development.

If you're not running the development branch, also known as version 3.0, of CodeIgniter you can easily take advantage of this functionality by changing the line

    define('ENVIRONMENT', 'development');

in index.php to

    define('ENVIRONMENT', isset($_SERVER['CI_ENV']) ? $_SERVER['CI_ENV'] : 'development');

I've tested this on my Arch Linux box so your mileage may vary.
