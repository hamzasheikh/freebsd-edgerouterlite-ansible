# Build FreeBSD Image for Ubiquiti EdgeRouter Lite with Vagrant and freebsd-ERL-build

This repo accompanies the blog post
[FreeBSD on EdgeRouter Lite - no serial port required](http://www.daemonology.net/blog/2016-01-10-FreeBSD-EdgeRouter-Lite.html)
and the git repo [freebsd-ERL-build](https://github.com/cperciva/freebsd-ERL-build/).
It doesn't re-implement the buildimage.sh script. Instead, it makes it easy to
spin up a new Vagrant environment to run the script - written by Colin Percival - to build the image.

Install make, [Vagrant](https://www.vagrantup.com/) and
[VirtualBox](https://www.virtualbox.org/).

For simplicity, I have removed any steps that required Ansible.

Clone this repo ([GitLab](https://gitlab.com/aikchar/freebsd-edgerouterlite-ansible),
[GitHub](https://github.com/hamzasheikh/freebsd-edgerouterlite-ansible),
[BitBucket](https://bitbucket.org/aikchar/freebsd-edgerouterlite-ansible)). 

Optionally, edit *Vagrantfile* to fit your requirements.

I'm using ``make`` to build the workflow. The included *Makefile* is pretty
simple to read and hack.

    $ make

Initialize your environment. Should need to do just once.

    $ make init

Build an image. On my machine it took about 50 minutes to complete a build.
It always pulls in newest changes from FreeBSD svn.

    $ make build

Monitor status of build. Shows tail of build log so you can see if it is done.

    $ make monitor

Once the image is built, copy it to your machine.

    $ make get

Write image to a USB thumb drive. Use the correct name of _your_ device in the
``of=`` part of the command.

    $ sudo dd if=erl-freebsd.img of=/dev/rdisk596870 bs=1m && sync

You can clean up some stuff in the Vagrant machine between builds.

    $ make clean

If you want to get rid of the Vagrant machine,

    $ make destroy
