{ config, pkgs, lib, vars, ... }:
{
  # Graphical stack basics (X11 for LXQt)
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true; # Qt-based DM
  services.xserver.desktopManager.lxqt.enable = true;

  # Sound
  # PipeWire as default modern audio stack
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Power management, backlight, etc.
  services.upower.enable = true;
  programs.light.enable = false; # prefer brightnessctl

  # Fonts minimal baseline (Noto family)
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    noto-fonts-extra
  ];
}
