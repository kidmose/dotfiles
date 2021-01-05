{ config, pkgs, ... }:
let
  s = import ./secrets.nix;
in
{
  imports = [
    ../../apps/cli.nix
    ../../apps/python.nix
    ./tools.nix
  ];

  fileSystems = pkgs.lib.mkVMOverride (
    {
      "/home/${s.os.user.name}" = {
        device = "home";
        fsType = "9p";
        options = [ "trans=virtio" "version=9p2000.L" ];
        neededForBoot = true;
      };
    }
  );

  nixpkgs.config.allowUnfree = true;
  # Boot loader
  boot.loader.timeout = 0;

  # Localisation
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "dk";
  };
  time.timeZone = "Europe/Copenhagen";

  users.mutableUsers = false;
  users.users.root.hashedPassword = "*";
  users.users.${s.os.user.name} = {
    isNormalUser = true;
    description = s.os.user.description;
    hashedPassword = s.os.user.hashedPassword;
    extraGroups = [
      "wheel"  # Enable ‘sudo’ for the user.
      "networkmanager"
      "docker"
      "wireshark"
    ];
    openssh.authorizedKeys.keys = s.os.user.keys;
  };
  security.sudo.wheelNeedsPassword = false;

  environment.interactiveShellInit = ''
    if test -f ~/.bashrc; then
        if [ -n "''${BASH_VERSION:-}" ]; then
            . ~/.bashrc
        fi
    fi
  '';

  services.openssh = {
    enable = true;
    forwardX11 = true;
    permitRootLogin = "no";
  };

  services.openvpn.servers.htb.config = (builtins.readFile ./profile.ovpn);

  # docker
  virtualisation.docker.enable = true;

  environment.systemPackages = with pkgs; [
    firefox
    emacs-nox # Because X11 forwarding emacs is broken
  ];
  programs.wireshark.enable = true;
  programs.wireshark.package = pkgs.wireshark; # does *-cli, i.e. tshark, by default

}
