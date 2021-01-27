{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xorg.xmodmap
    # xcape
    # hsetroot
    arandr                    # UI for xrandr (display controlling)
    clipmenu
  ];

  # Monitor management
  services.autorandr.enable = true; # Fix monitor layout when sleeping/waking up
  systemd.user.services.autorandr-start = { # Fix monitor layout on log-in
    # TODO: Instead of doing it after loging, do it as root with --batch before x11 is started
    description = "Fix monitor layout on login";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      StartLimitInterval = 5;
      StartLimitBurst = 1;
      ExecStart = "${pkgs.autorandr}/bin/autorandr --change";
      Type = "oneshot";
      RemainAfterExit = false;
    };
  };

  services.clipmenu.enable = true; # light clipboard manager
  environment.variables.CM_LAUNCHER = "rofi"; # use rofi in clipmanager


  services.tlp = { # Power Management
    settings = {
      # DISK_DEVICES = "nvme0n1";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      ENERGY_PERF_POLICY_ON_BAT = "powersave";
    };
    enable = true; 
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "dk";
    xkbOptions = builtins.concatStringsSep ", " [ # https://github.com/NixOS/nixpkgs/pull/73394
      "eurosign:e"
      "caps:ctrl_modifier"
    ];
    # Enable touchpad support.
    libinput.enable = true;
  };
}
