{ config, lib, pkgs, stdenv, ... }:
{

  imports = [
    ./x11.nix
    ./clipboard.nix
  ];

  # services.blueman.enable = true;

  environment = {
    systemPackages = with pkgs; [
      # locking
      xsecurelock

      # appearance
      dunst                     # notfication daemon
      slstatus

      # applications
      # dmenu # Maybe this over rofi?
      rofi
      xsettingsd
      acpilight                # provides xbacklight
      brightnessctl

      xorg.xprop               # needed for copy/paste
      xdotool                  # needed for copy/paste
      xorg.xdpyinfo

      # I don't know why:
      qtpass
      polybar
      st
    ];
  };

  services.xserver = {

    displayManager = {
      lightdm.enable = true; # manages log-in
      defaultSession = "none+i3";
      sessionCommands = ''
        xsetroot -solid black &
      '';
    };

    desktopManager = {
      xterm.enable = false; # Am I doing this to not start a default one?
    };

    windowManager = {
      i3.enable = true;
    };
  };
}
