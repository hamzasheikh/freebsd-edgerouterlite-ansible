MACHINE := freebsd12current

.PHONY: help
help:
	@echo Main steps in the workflow:
	@echo make init \#\# Only needed once
	@echo make build \#\# Build FreeBSD image for ERL
	@echo make monitor \#\# Shows tail of build log so you can see if it is done
	@echo make get \#\# Download the FreeBSD image from Vagrant machine
	@echo make clean \#\# Cleans up stuff in Vagrant machine
	@echo make destroy \#\# !!! CAUTION !!! Removes Vagrant machine

.PHONY: init
init: vagrant-init seed

.PHONY: vagrant-init
vagrant-init:
	vagrant plugin install vagrant-scp
	vagrant box update --provider virtualbox $(MACHINE) || vagrant box add --provider virtualbox 'freebsd/FreeBSD-12.0-CURRENT'
	vagrant up

.PHONY: seed
seed:
	# vagrant scp fbsd.init.sh $(MACHINE):/home/vagrant/fbsd.init.sh
	vagrant scp fbsd.build.sh $(MACHINE):/home/vagrant/fbsd.build.sh
	vagrant ssh -c 'chmod u+x /home/vagrant/fbsd.*.sh' $(MACHINE)

.PHONY: build
build:
	vagrant ssh -c 'tmux has-session -t build' $(MACHINE) || vagrant ssh -c 'tmux new-session -s build -d' $(MACHINE)
	vagrant ssh -c 'tmux send-keys -t build "/home/vagrant/fbsd.build.sh" C-m' $(MACHINE)

.PHONY: monitor
monitor:
	vagrant ssh -c 'tail ~/build.log'

.PHONY: get
get:
	pipenv run vagrant scp $(MACHINE):/home/vagrant/erl-freebsd.img erl-freebsd.img

.PHONY: clean
clean:
	vagrant ssh -c 'tmux send-keys -t build "sudo rm -rf /home/vagrant/ERLBUILD.*" C-m' $(MACHINE)
	vagrant ssh -c 'tmux kill-session -t build' $(MACHINE)

.PHONY: destroy
destroy:
	vagrant destroy -f
