{ config, pkgs, lib, vars, ... }:
{
  # Stylix theming (optional, can be disabled)
  stylix = lib.mkIf vars.enableStylix {
    enable = true;
    fonts = {
      monospace = "Noto Sans Mono";
      sansSerif = "Noto Sans";
      serif = "Noto Serif";
    };
    # E-ink inspired palette
    base16Scheme = {
      name = "E-Ink";
      author = "GitHub Copilot";
      colors = {
        base00 = "#cccccc"; # light gray
        base01 = "#444444"; # dark gray
        base02 = "#222222"; # text/borders
        base03 = "#222222";
        base04 = "#444444";
        base05 = "#222222";
        base06 = "#cccccc";
        base07 = "#cccccc";
        base08 = "#222222";
        base09 = "#444444";
        base0A = "#cccccc";
        base0B = "#444444";
        base0C = "#cccccc";
        base0D = "#444444";
        base0E = "#222222";
        base0F = "#444444";
      };
    };
  };

  # LXQt adjunct utilities kept minimal
  environment.systemPackages = with pkgs; [
    lxqt.lxqt-config
    lxqt.lxqt-panel
    lxqt.lxqt-session
    lxqt.lxqt-policykit
    lxqt.lxqt-powermanagement
    lxqt.lxqt-notificationd
    lxqt.lxqt-globalkeys
    # file manager kept light
    pcmanfm-qt
  ];
}
