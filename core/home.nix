{ config, lib, pkgs, vars, ... }:
{
  # Import core user packages and optional feature modules as desired
  imports = [
    ../modules/user.nix
    # App-specific configuration modules
    ../modules/apps/terminal.nix
    ../modules/apps/media.nix
    ../modules/apps/monitoring.nix
  ]
  ++ lib.optionals vars.enableMedia [ ../modules/media.nix ]
  ++ lib.optionals vars.enableProductivity [ ../modules/productivity.nix ]
  ++ lib.optionals vars.enableDev [ ../modules/dev.nix ]
  ++ lib.optionals vars.enableSecurity [ ../modules/security.nix ];

  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  programs.home-manager.enable = true;

}
