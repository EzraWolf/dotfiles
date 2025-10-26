{
  config,
  pkgs,
  vars,
  ...
}: {
  # Stylix theming (optional, can be disabled)
  stylix = {
    enable = true;
    fonts = {
      monospace = {
        package = pkgs.noto-fonts;
        name = "Noto Sans Mono";
      };
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      emoji = {
        package = pkgs.nerd-fonts.symbols-only;
        name = "Symbols Nerd Font Mono";
      };
    };

    # E-ink inspired palette
    base16Scheme = {
      scheme = "eink";
      author = "Who cares.";
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

  # Graphical stack setup
  # xdg.portal.lxqt.enable = true;
  # services.xserver.displayManager.sddm.enable = true; # Qt-based DM
  # services.xserver.desktopManager.lxqt.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # LXQt adjunct utilities kept minimal
  #environment.systemPackages = with pkgs; [
  #  lxqt.lxqt-qtplugin
  #  lxqt.lxqt-config
  #  lxqt.lxqt-panel
  #  lxqt.lxqt-session
  #  lxqt.lxqt-policykit
  #  lxqt.lxqt-powermanagement
  #  lxqt.lxqt-notificationd
  #  lxqt.lxqt-globalkeys
    # file manager kept light
  #  pcmanfm-qt
  #  noto-fonts
  #  noto-fonts-emoji
  #  noto-fonts-extra
    # nerd-fonts-symbols
  #];
}
