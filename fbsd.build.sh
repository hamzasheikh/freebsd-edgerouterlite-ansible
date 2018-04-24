#!/bin/sh
set -e
(cd /home/vagrant/freebsd-ERL-build && git pull --quiet) || git clone --quiet https://github.com/cperciva/freebsd-ERL-build /home/vagrant/freebsd-ERL-build
/usr/bin/svnlite --quiet update /home/vagrant/src || /usr/bin/svnlite --quiet checkout svn://svn.freebsd.org/base/head /home/vagrant/src
script -a /home/vagrant/build.log sudo /bin/sh /home/vagrant/freebsd-ERL-build/buildimg.sh /home/vagrant/src /home/vagrant/erl-freebsd.img
sudo chown vagrant:vagrant /home/vagrant/erl-freebsd.img
