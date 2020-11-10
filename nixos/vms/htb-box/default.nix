# Build a virtualbox image (*.ova) from ./configuration.nix

## Usage:
#
#     nix-build
#     VBoxManage import result/*.ova --vsys 0 --vmname htb-box
#     VBoxManage startvm htb-box
#

(import <nixpkgs/nixos> {
  configuration = { lib, ... }: with lib; {
    imports = [
      <nixpkgs/nixos/modules/virtualisation/virtualbox-image.nix>
      ./configuration.nix
    ];
    virtualbox.memorySize = 2048;
    # virtualbox.params.clipboard = "bidirectional";
    # virtualbox.clipboard = [];
  };
}).config.system.build.virtualBoxOVA.overrideAttrs (oldAttrs: rec{
  postVM = "";
})
