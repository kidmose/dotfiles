#!/usr/bin/env bash
#
# Build a QEMU virtual machine from ./configuration.nix
# Based on: http://blog.patapon.info/nixos-local-vm/
#
set -e

nix-build '<nixpkgs/nixos>' -A vm --arg configuration ./configuration.nix
QEMU_NET_OPTS=hostfwd=tcp::2221-:22 ./result/bin/run-nixos-vm -smp $(nproc) -m 8G -display none
