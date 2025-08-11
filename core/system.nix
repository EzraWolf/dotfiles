{
  config,
  pkgs,
  lib,
  vars,
  ...
}: {
  # System packages are collected via modules/system.nix
  imports = [
    ../modules/system.nix
  ];

  time.timeZone = vars.timezone;
  i18n.defaultLocale = vars.locale;
  i18n.extraLocaleSettings = {
    LC_TIME =
      if vars.time24h
      then "en_DK.UTF-8"
      else vars.locale;
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap =
      if (vars ? keyboardmap)
      then vars.keyboardmap
      else "us";
  };

  nixpkgs.config.allowUnfree = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = vars.computer;
  networking.networkmanager.enable = true;

  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.username;
    extraGroups = ["wheel" "networkmanager" "docker"];
    shell = pkgs.zsh;
  };

  services.openssh.enable = true;
  services.printing.enable = true;
  services.fstrim.enable = true;
  services.udisks2.enable = true;

  fonts.packages = with pkgs; [
    # Noto font family
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    nerd-fonts.symbols-only # Noto is superior but symbols are cool
  ];

  system.stateVersion = vars.version;
}
