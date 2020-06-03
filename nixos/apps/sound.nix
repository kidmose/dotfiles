{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    pavucontrol # PulseAudio mixer (GUI)
  ];

  # ALSA kernel module
  sound.enable = true;
  # PulseAudio: Sound server, in user space, on top of ALSA
  hardware.pulseaudio.enable = true;

  users.users.egk.extraGroups = [ # TODO: username here...
    "audio"
  ];
}
