{ config, pkgs, ... }:
{
  imports = [
    ./x11.nix
  ];

  environment.systemPackages = with pkgs; [
    xfce.xfce4-panel
    xfce.xfce4-notifyd
    xfce.xfce4-battery-plugin
    xfce.xfce4-hardware-monitor-plugin
    # xfce.xfce4-mailwatch-plugin
    xfce.xfce4-namebar-plugin
    xfce.xfce4-xkb-plugin
    xsecurelock

    papirus-icon-theme
    rofi
  ];

  services.xserver = {
    desktopManager = {
      xfce = {
        enable = true;
        thunarPlugins = with pkgs.xfce; [
          thunar-archive-plugin
          thunar_volman
        ];

        noDesktop = true;
        enableXfwm = false;
      };

      default = "xfce";
    };

    windowManager = {
      i3.enable = true;
      default = "i3";
    };

    displayManager.lightdm.enable = true;
  };
}
