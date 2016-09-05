Build FreeBSD Image for Ubiquiti EdgeRouter Lite with Vagrant, Ansible, and freebsd-ERL-build
=============================================================================================

This repo accompanies the blog post
`FreeBSD on EdgeRouter Lite - no serial port required <http://www.daemonology.net/blog/2016-01-10-FreeBSD-EdgeRouter-Lite.html>`_
and the git repo `freebsd-ERL-build <https://github.com/cperciva/freebsd-ERL-build/>`_.
It doesn't re-implement the buildimage.sh script. Instead, it makes it easy to
spin up a new Vagrant environment to run the script - written by Colin Percival
- to build the image.

How?
----

Install `Vagrant <https://www.vagrantup.com/>`_,
`VirtualBox <https://www.virtualbox.org/>`_, and
`Ansible <https://pypi.python.org/pypi/ansible>`_.

Clone this repo. Optionally, edit *Vagrantfile* or *play.yml* to fit your
requirements. Run Vagrant.

::

    user@host$ vagrant up

Once the machine is up and provisioned SSH into it.

::

    user@host$ vagrant ssh freebsd11

Run ``buildimage.sh`` to create an image. On my machine it took about
??? minutes to complete a build.

::

    vagrant@freebsd11$ sudo /bin/sh /home/vagrant/freebsd-ERL-build/buildimg.sh /home/vagrant/src /home/vagrant/erl-freebsd.img

Change file permissions.

::

    vagrant@freebsd11$ sudo chown vagrant:vagrant /home/vagrant/erl-freebsd.img

Log out of the SSH session and copy the image to your machine.

::

    vagrant@freebsd11$ exit
    user@host$ vagrant scp freebsd11:/home/vagrant/erl-freebsd.img .

Write image to a USB thumb drive. Use the correct name of _your_ device in the
``of=`` part of the command.

::

    user@host$ sudo dd if=erl-freebsd.img of=/dev/rdisk596870 bs=1m && sync

Updates
-------

In future -- when you need to build newer versions -- update the subversion
repo and build a new image.

::

    user@host$ vagrant ssh freebsd11
    vagrant@freebsd11$ cd /home/vagrant/src
    vagrant@freebsd11$ svnlite update
    vagrant@freebsd11$ cd /home/vagrant
    vagrant@freebsd11$ sudo rm -rf /home/vagrant/ERLBUILD.*
    vagrant@freebsd11$ sudo /bin/sh /home/vagrant/freebsd-ERL-build/buildimg.sh /home/vagrant/src /home/vagrant/erl-freebsd.img
