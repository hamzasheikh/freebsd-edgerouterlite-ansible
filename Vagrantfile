# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.provider 'virtualbox' do |v|
    v.memory = 4096
    v.cpus = 4
  end

  config.vm.define 'freebsd12current' do |fbsd|

    fbsd.vm.box = "freebsd/FreeBSD-12.0-CURRENT"

    fbsd.vm.box_check_update = true

    # With the line commented in Vagrant v 1.8.1,
    # ``vagrant up`` gives this error:
    #
    # No base MAC address was specified. This is required for the NAT networking
    # to work properly (and hence port forwarding, SSH, etc.). Specifying this
    # MAC address is typically up to the box and box maintainer. Please contact
    # the relevant person to solve this issue.
    #
    # The error doesn't show when ``vagrant up`` is run a second time
    # e.g. ``vagrant up; vagrant up``
    fbsd.vm.base_mac = "000AAAAAAAAA"

    fbsd.vm.guest = :freebsd

    fbsd.vm.hostname = "freebsd12current"

    # With the line uncommented in Vagrant v 1.8.1,
    # ``vagrant up`` gives this error:
    #
    # The following SSH command responded with a non-zero exit status.
    # Vagrant assumes that this means the command failed!
    # dhclient em1
    # Stdout from the command:
    # Stderr from the command:
    # dhclient already running, pid: 387.
    # exiting.
    #
    # This is fixed in master branch as of March 1, 2016, but not in v 1.8.1
    # PR https://github.com/mitchellh/vagrant/pull/7093
    fbsd.vm.network "private_network", type: "dhcp", auto_config: false
    # fbsd.vm.network "public_network", type: "dhcp", auto_config: false, bridge: "en0: Wi-Fi (AirPort)", mac: "080027976B38"
    # Workaround from
    # http://stackoverflow.com/questions/33569922/vagrant-network-configuration-with-slackware-box
    fbsd.vm.provision "shell", run: "always", inline: "/usr/sbin/service netif restart em1"

    fbsd.vm.synced_folder ".", "/vagrant_data", disabled: true

    fbsd.ssh.shell = "/bin/sh"

    fbsd.vm.provision "ansible" do |ansible|
      ansible.verbose = "v"
      ansible.playbook = "play.yml"
    end
  end
end
