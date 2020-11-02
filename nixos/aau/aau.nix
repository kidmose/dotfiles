# AAU specific stuff
{config, pkgs, ...}:
let
  s = import ../secrets.nix;
in
{
  # DavMail: Expose Exchange in a more open way
  services.davmail = {
    enable = true;
    url = "https://mail.aau.dk/EWS/Exchange.asmx";
    config = {
      # General
      davmail.mode = "EWS";
      davmail.disableUpdateCheck = true;
      # network
      davmail.bindAddress = "127.0.0.1";
      davmail.caldavPort = 1080;
      davmail.caldavPastDelay=90;
      # disable by setting to empty
      davmail.imapPort = ""; # 1143;
      davmail.ldapPort = 1389; # 1389;
      davmail.popPort = ""; # 1110;
      davmail.smtpPort = ""; # 1025;
      # logging
      davmail.logFilePath = "/var/log/davmail/davmail.log";
      davmail.logFileSize = "1MB";
      log4j.logger.davmail = "WARN";
      log4j.logger.httpclient.wire = "WARN";
      log4j.logger.org.apache.commons.httpclient = "WARN";
      log4j.rootLogger = "WARN";
    };
  };

  # Periodic download of calendar
  #
  # store password to gnome3-keyring with:
  #     $ secret-tool store --label=davmail caldav2org password
  #
  systemd.user.services.caldav2org = {
    description = "Fetch events from local caldav service and save them as ~/.caldav.org";
    script = "${pkgs.curl}/bin/curl -sS -u ${s.aau.email}:$(${pkgs.libsecret}/bin/secret-tool lookup caldav2org password) localhost:${toString config.services.davmail.config.davmail.caldavPort}/users/${s.aau.email}/calendar/ | ${pkgs.coreutils}/bin/tee .caldav.ics | ${pkgs.ical2org}/bin/ical2org -o ~/.caldav.org -";
    serviceConfig = {
      StartLimitInterval = 5;
      StartLimitBurst = 1;
      Type = "oneshot";
      RemainAfterExit = false;
      TimeoutSec=10;
    };
  };
  systemd.user.timers.caldav2org= {
    description = "Fetch caldav events to org every 30 minutes";
    timerConfig = {
      OnStartupSec="1s";
      OnUnitInactiveSec = "30m";
    };
    wantedBy = [ "timers.target" ];
    partOf = [ "caldav2org.service" ];
  };
}
