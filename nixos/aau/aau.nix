# AAU specific stuff
{config, pkgs, ...}:
{
  imports =
    [
      <nixos-hardware/lenovo/thinkpad/t450s>
    ];
  
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
      # disable by setting to empty
      davmail.imapPort = ""; # 1143;
      davmail.ldapPort = ""; # 1389;
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

}
