# https://github.com/garbas/dotfiles/blob/76f9da7c5d84b1595e8b9af31505bb13968ba7a4/nixos/grayworm.nix#L63

{ config, lib, pkgs, ... }:

let
  custom_pkgs = self: super: {

    uhk-agent =
      # version >1.3.0 causes it to hang on launch ("Loading configuration. Hang on")
      let
        version = "1.3.0";
        image = self.stdenv.mkDerivation {
          name = "uhk-agent-image";
          src = self.fetchurl {
            url = "https://github.com/UltimateHackingKeyboard/agent/releases/download/v${version}/UHK.Agent-${version}-linux-x86_64.AppImage";
            # sha256 = "1gr3q37ldixcqbwpxchhldlfjf7wcygxvnv6ff9nl7l8gxm732l6"; # 1.2.12 - good
            sha256 = "09k09yn0iyivc9hf283cxrcrcyswgg2jslc85k4dwvp1pc6bpp07"; # 1.3.0 - good
            # sha256 = "0inps9q6f6cmlnl3knmfm2mmgqb5frl4ghxplbzvas7kmrd2wg4k"; # 1.3.1 - bad
            # sha256 = "1y2n2kkkkqsqxw7rsya7qxh8m5nh0n93axcssi54srp3h7040w3h"; # 1.3.2 - bad
            # sha256 = "1y6gy3zlj0pkvydby7ibm7hx83lmc3vs2m0bfww5dq1114j99dy5"; # 1.4.0 - bad
          };
          buildCommand = ''
            mkdir -p $out
            cp $src $out/appimage
            chmod ugo+rx $out/appimage
          '';
        };
      in self.runCommand "uhk-agent" {} ''
        mkdir -p $out/bin $out/etc/udev/rules.d
        echo "${self.appimage-run}/bin/appimage-run ${image}/appimage" > $out/bin/uhk-agent
        chmod +x $out/bin/uhk-agent
        cat > $out/etc/udev/rules.d/50-uhk60.rules <<EOF
        # Ultimate Hacking Keyboard rules
        # These are the udev rules for accessing the USB interfaces of the UHK as non-root users.
        # Copy this file to /etc/udev/rules.d and physically reconnect the UHK afterwards.
        SUBSYSTEM=="input", GROUP="input", MODE="0666"
        SUBSYSTEMS=="usb", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="612[0-7]", MODE:="0666", GROUP="plugdev"
        KERNEL=="hidraw*", ATTRS{idVendor}=="1d50", ATTRS{idProduct}=="612[0-7]", MODE="0666", GROUP="plugdev"
        EOF
      '';

  };
in
{
  nixpkgs.overlays = [
    custom_pkgs
  ];
  environment.systemPackages = with pkgs; [
    uhk-agent
  ];
  services.udev.packages = with pkgs; [ uhk-agent ];
}
