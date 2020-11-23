{ configuration
, system ? builtins.currentSystem
}:

let

  eval = modules: import <nixpkgs/nixos/lib/eval-config.nix> {
    inherit system modules;
  };

in {

  vmSystem =
    (eval [ configuration <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix> ]).config.system.build.toplevel;

}
