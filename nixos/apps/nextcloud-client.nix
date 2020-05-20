# Nextcloud client with a systemd unit for the user
#
# Bugs:
#
#  - Does not create a tray icon (under my i3wm)
#
#    Nextcloud seems to have some annoying assumptions about how GUIs
#    are done...

{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nextcloud-client
  ];

  systemd.user.services.nextcloud-client = {
    description = "Nextcloud Desktop Client running";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /tmp/\${USER}/log/nextcloud";
      ExecStart = "${pkgs.nextcloud-client}/bin/nextcloud --background --logdir /tmp/\${USER}/log/nextcloud --logexpire 12";
      Type = "simple";
    };
  };
}
