{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xorg.xmodmap
    # xcape
    # hsetroot
  ];

  services.autorandr.enable = true; # Monitor management
  services.tlp = { # Power Management
    extraConfig = ''
      # DISK_DEVICES="nvme0n1"
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
      ENERGY_PERF_POLICY_ON_BAT=powersave
    '';
    enable = true; 
  };

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "dk";
    xkbOptions = "eurosign:e";
    # Enable touchpad support.
    libinput.enable = true;
  };
}
