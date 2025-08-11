{ config, lib, pkgs, vars, ... }:
{
  imports = [
    ../core/system.nix
    ../core/services.nix
    ../core/desktop.nix
  ] ++ lib.optional (builtins.pathExists ./hardware-laptop.nix) ./hardware-laptop.nix
    ++ lib.optionals vars.enableGaming [ ../modules/gaming.nix ];

  # Example machine-specific toggles (GPU, drivers, etc.) can be added here
  hardware.bluetooth.enable = false;
}
