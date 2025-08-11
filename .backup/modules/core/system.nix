# Misc. NixOS setup here.
# Bootloaders, networking, locales, fonts, etc.

{ config, pkgs, vars, ... }:

{
  # --- NixOS Settings ---
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # --- Bootloader ---
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- Networking ---
  networking.networkmanager.enable = true;
  networking.hostName = vars.userhost;

  # --- Locale and Time ---
  time.timeZone = vars.timezone;
  i18n.defaultLocale = vars.locale;
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
  
  console = {
    font = "Lat2-Terminus16";
    keyMap = vars.keyboardmap; # Fixed: Added semicolon
  };

  # --- Fonts (Noto + Nerd Font symbols) ---
  fonts.packages = with pkgs; [
    # Noto font family
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.symbols-only # Noto is superior but symbols are cool
];

  # --- Enable Wayland/Hyprland ---
  programs.hyprland.enable = true;
  
  # --- XDG Portal (required for Wayland) ---
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk # For file dialogs
    ];
  };

  # --- Enable SDDM Display Manager ---
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
  };
}

