# Build a QEMU virtual machine from ./configuration.nix
# Based on: http://blog.patapon.info/nixos-local-vm/
#
# Specify "Hostname", "Port", and "User" for a "Host" named "target" in `./ssh-config`

push: $(wildcard *.nix)
	outPath=$$(nix-build -A vmSystem --arg configuration ./configuration.nix); \
	NIX_SSHOPTS="-F ssh-config" nix-copy-closure --to "target" --gzip "$$outPath"; \
	ssh -F ssh-config target sudo nix-env --profile "/nix/var/nix/profiles/system" --set "$$outPath"; \
	ssh -F ssh-config target sudo $$outPath/bin/switch-to-configuration test

local: $(wildcard *.nix)
	nix-build '<nixpkgs/nixos>' -A vm --arg configuration ./configuration.nix
	QEMU_NET_OPTS=hostfwd=tcp::2221-:22 ./result/bin/run-nixos-vm -smp $$(nproc) -m 8G -display none 

clean:
	rm -v result nixos.qcow2

