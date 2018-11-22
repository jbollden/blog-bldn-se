+++
author = ""
comments = true
date = "2012-08-12T15:56:00+02:00"
draft = false
image = ""
menu = ""
share = true
slug = "use-latest-codeigniter-in-your-project"
tags = [ "codeigniter", "framework", "php", "web" ]
title = "Use latest CodeIgniter in your project"

+++

The development branch of the PHP framework CodeIgniter resides on GitHub and can be cloned by anyone. This article will outline a suggestion on how to set up a project that is continuously based on the latest version available in the repository.

I'll explain how to create, develop and maintain your project through the following steps:

* Prepare your project area
* Fetch latest CodeIgniter
* Copy directories and files
* Start development of your project
* Update CodeIgniter

## Prepare your project area

Create a directory that will hold your project and CodeIgniter:

    $ mkdir -p Projects/your-project

## Fetch latest CodeIgniter

Use git to get a copy of CodeIgniter from the repository at GitHub:

    $ cd Projects
    $ git clone https://github.com/EllisLab/CodeIgniter.git

## Copy directories and files
Now copy the application folder from the cloned CodeIgniter. This is where your development will be done:

    $ cp -r CodeIgniter/application your-project/

It is also good practice to create a public area where you place the CodeIngniter index.php-file and other public accessible assets (e.g. css, images, scripts):

    $ mkdir -p your-project/public/assets
    $ cp CodeIgniter/index.php your-project/public

## Start development of your project

Before starting your development you will need to edit the copied index.php-file. In this file there are two settings that needs your attention; the $system_path and $application_folder. It is possible to use relative paths:

    $system_path = '../../CodeIgniter/system';
    $application_folder = '../application';

At this point all is set for your development to start.

## Update CodeIgniter

Once and a while you'll need to update your fetched version of CodeIgniter, once a week could be a good rule of thumb.

    $ cd Projects/CodeIgniter
    $ git pull

This will fetch the latest version from the repository, if the response is

    Already up-to-date.

then all is well. If the git command returns some sort of list then your version has been updated and you need to check if there are any file in the application-folder that has been updated.

For each file in CodeIgniter's application-folder that has been updated you need to merge the changes with the file in your project. Changes are usually small and the merge can usually be done by hand. First use diff to locate what has changed.

## Conclusion

The directory tree of the above suggestion looks like this:
<pre>
Projects
+-- CodeIgniter
|   +-- application
|   +-- system
|   +-- tests
|   \`-- user_guide_src
\`-- your-project
    +-- application
    \`-- public
</pre>

And the application-folder in your-project is initially a copy of the application-folder in CodeIgniter.

