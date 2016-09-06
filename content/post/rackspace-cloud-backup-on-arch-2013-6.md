+++
author = ""
comments = true
date = "2013-08-26T12:02:99"
draft = false
image = ""
menu = ""
share = true
slug = "rackspace-cloud-backup-on-arch-2013-6"
tags = ["arch linux", "cloud", "rackspace"]
title = "Rackspace Cloud Backup on Arch 2013.6"

+++

Since the applications, data, and services on my Rackspace (this) server is becoming more and more important I decided to look into Rackspace's Cloud Backup service. However, I ran into trouble during the setup of the service, and this article tries to describe how it was solved.

I followed their guide to [Install the Agent](http://www.rackspace.com/knowledge_center/article/rackspace-cloud-backup-install-the-agent). There is an [AUR](https://aur.archlinux.org/packages/driveclient/) for the `driveclient` that could be used, but at the moment I'm not that keen on using AUR's, and at the time of writing the version in the AUR is also a bit old.

After configuring and starting the `driveclient` as instructed I went on to the second step [Create a Backup](http://www.rackspace.com/knowledge_center/article/rackspace-cloud-backup-create-a-backup-0). The backup failed and I examined the log file, `/var/log/driveclient.log` that yielded the following:

    [2013-08-26 10:27:24|...|WARN |Http|rax::http::NetworkError::Type rax::HttpClient::ExamineLayer4Errors(474)] HTTP: Connection timed out while waiting for https://snet-storage101.lon3.clouddrive.com/v1.0/MossoCloudFS_ ...
    [2013-08-26 10:27:24|...|ERROR|root|rax::Backup::PerformBackup(202)] Backup: Unable to complete the backup (1486201). Details: 1: [rax::HttpResponse local::&lt;unnamed&gt;::CurlEasyPerformWrapper(CURL*, rax::HttpContext&amp;): 239-rax::HttpResponse local::&lt;unnamed&gt;::CurlEasyPerformWrapper(CURL*, rax::HttpContext&amp;)] Ex Code(2000): Could not perform an HTTP request. Timeout was reached (28)
    [2013-08-26 10:27:24|...|ERROR|root|rax::Backup::MakeReport(332)] Failed to start backup: 1: [rax::HttpResponse local::&lt;unnamed&gt;::CurlEasyPerformWrapper(CURL*, rax::HttpContext&amp;): 239-rax::HttpResponse local::&lt;unnamed&gt;::CurlEasyPerformWrapper(CURL*, rax::HttpContext&amp;)] Ex Code(2000): Could not perform an HTTP request. Timeout was reached (28) Error during backup initialization.

This made me turn to the always excellent Customer Support at Rackspace, and it seemed that I were missing some routes. I issued the following commands to add the correct routes to the service net (`eth1`):

    # ip route add 10.176/12 via 10.179.64.1
    # ip route add 10.208/12 via 10.179.64.1</pre>

I restarted the backup from Rackspace's Control Panel and it completed successfully.

But after rebooting my server the routes were ones again gone and the backup subsequently failed. At this point I started to examine the `netctl` profile for `eth1` (`/etc/netctl/eth1`). The configuration file stated:

    ROUTES=('10.208.0.0/255.240.0.0 via 10.179.64.1 10.176.0.0/255.240.0.0 via 10.179.64.1')

which is the `netcfg` configuratiion. Simply change `ROUTES` to `Routes` and, for readablity add `'` to separate the instructions (`netctl` will fix this by itself if you don't add the `'`):

    Routes=('10.208.0.0/255.240.0.0 via 10.179.64.1' '10.176.0.0/255.240.0.0 via 10.179.64.1')

To finish up the installation of the `driveclient` I added the following to the service file `/etc/systemd/system/driveclient.service`:

    [Unit]
    Description=Rackspace backup agent
    After=network.target
    
    [Service]
    ExecStart=/usr/local/bin/driveclient
    
    [Install]
    WantedBy=multi-user.target</pre>

Followed by enabling and starting the service:

    # systemctl enable driveclient
    # systemctl start driveclient

I'm told that the Rackspace team is now aware of the problem with the routes configuration for the `eth1` interface and should not cause any problem when installing a new Arch Linux server.
