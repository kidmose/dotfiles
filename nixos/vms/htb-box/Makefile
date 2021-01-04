# Build a QEMU virtual machine from ./configuration.nix
# Based on: http://blog.patapon.info/nixos-local-vm/
#
# Specify "Hostname", "Port", and "User" for a "Host" named "target" in `./ssh-config`

PIDFILE := /tmp/htb-box.pid
SSHPORT := 2221

# TODO:
#
#  * Fix the "push" target so updated configurations can be pushed to
#    a live VM, as demonstrated here:
#    http://blog.patapon.info/nixos-local-vm/
#  * Do things the proper Nix way; Get rid of this Makefile and
#    instead declare scripts for the Makefile-targets in a nix
#    deriviation.
#

# push: $(wildcard *.nix)
# 	nix-build -A vmSystem --arg configuration ./configuration.nix
# 	echo "Result: $$(readlink -f result)"
# 	NIX_SSHOPTS="-F ssh-config" nix-copy-closure --to "target" --gzip "$$(readlink -f result)"
# 	ssh -F ssh-config target sudo nix-env --profile "/nix/var/nix/profiles/system" --set "$$(readlink -f result)"
# 	ssh -F ssh-config target sudo "$$(readlink -f result)/bin/switch-to-configuration test"

local: $(wildcard *.nix)
	nix-build '<nixpkgs/nixos>' -A vm --arg configuration ./configuration.nix
	QEMU_NET_OPTS=hostfwd=tcp::$(SSHPORT)-:22 ./result/bin/run-nixos-vm -smp $$(nproc) \
	 -m 8G -display none \
	 -virtfs local,path=$$(readlink -f ./home),security_model=mapped,mount_tag=home \
	 -pidfile $(PIDFILE) -daemonize

kill:
	kill $$(cat $(PIDFILE))

clean:
	if [ -f "$(PIDFILE)" ]; then kill "$$(cat $(PIDFILE))" && sleep 1 || true; fi
	rm -rfv result nixos.qcow2 $(PIDFILE)
