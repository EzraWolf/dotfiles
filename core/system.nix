{ config, pkgs, lib, vars, ... }:
{
  # vars are provided by flake.nix via specialArgs
  networking.hostName = vars.userhost;

  time.timeZone = vars.timezone;
  i18n.defaultLocale = vars.locale;
  i18n.extraLocaleSettings = {
    LC_TIME = if vars.time24h then "en_DK.UTF-8" else vars.locale;
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
    keyMap = if (vars ? keyboardmap) then vars.keyboardmap else "us";
  };

  nixpkgs.config.allowUnfree = true;

  # Bootloader (simple default, adjust to your system later)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Users
  users.users.${vars.username} = {
    isNormalUser = true;
    description = vars.username;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.zsh;
  };

  # Core services
  services.openssh.enable = true;
  services.printing.enable = false;
  services.fstrim.enable = true;
  services.udisks2.enable = true;

  # Networking
  networking.networkmanager.enable = true;

  # Docker (requested for system pkgs)
  virtualisation.docker.enable = true;

  # Default editor
  programs.nano.enable = true;
  programs.zsh.enable = true;

  # System packages are collected via modules/system.nix
  imports = [ ../modules/system.nix ];
}
