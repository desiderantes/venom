Installation
============
- [Linux](#linux)
- [OS X](#os-x)
- [Windows](#windows)
- [FAQ](#faq)

Linux
=====

Follow toxcore [installation instructions](https://github.com/irungentoo/toxcore/blob/master/INSTALL.md#linux).
Don't forget to install it after building it.

Dependencies
------------

Additionally to the tox build dependencies, you will need:

| Package name     | Version   | Comment        |
|------------------|-----------|----------------|
| valac            | >=0.28.0  |                |
| bake             | >=0.1.33  | If not available, please use a release tarball |
| libgtk-3-dev     | >=3.12    |                |
| libjson-glib-dev | >=0.14    |                |
| libsqlite3-dev   | >=3.7     |                |
| libsqlheavy-dev  | >=0.1.1   | Might be replaced by libgda in the future |

Ubuntu >= 14.04 (Trusty Tahr) / Linux Mint / Debian:
	
    apt-get install valac bake libgtk-3-dev libjson-glib-dev libsqlite3-dev libsqlheavy-dev

Fedora: (Assuming you have the Bake build system available)

    yum install vala bake gtk3-devel json-glib-devel sqlite-devel sqlheavy-devel

Arch Linux: (Assuming you have the Bake build system available)

    pacman -S vala bake gtk3 json-glib sqlite sqlheavy

Building and installing Venom
-----------------------------

After you installed the dependencies, you can use use two Venom versions:

Git version: clone, build and install venom:

    git clone git://github.com/desiderantes/venom.git
    cd venom
    bake
    bake release-deb
    sudo dpkg -i venom.deb
	
Tarball release:
	tar -xfz venom-{version}.tar.gz
	cd venom
	./configure
	make
	sudo make install
	
OS X
====

Unsupported, please wait for the [official Tox for OSX](https://github.com/Tox/Tox-OSX/)

Windows
=======

Unsupported, please use another client, like [uTox](https://utox.org).

FAQ
===
#### Why Bake instead of CMake, autotools, Waf, etc.
	Bake is a build system with a easy syntax and support for a lot of Vala and Gtk+ tasks
	like GResources, Composite templates, and translations, without macros or external scripts
	Also, bake syntax is so easy that modifying the build is not a problem for a newbie.
	You can get more information at the [Bake website](https://launchpad.net/bake) 
