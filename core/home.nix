{ config, lib, pkgs, vars, ... }:
{
  # Import core user packages and optional feature modules as desired
  imports = [ ../modules/user.nix ]
  ++ lib.optionals vars.enableMedia [ ../modules/media.nix ]
  ++ lib.optionals vars.enableProductivity [ ../modules/productivity.nix ]
  ++ lib.optionals vars.enableDev [ ../modules/dev.nix ]
  ++ lib.optionals vars.enableSecurity [ ../modules/security.nix ]
  ++ lib.optionals vars.enableStylix [ inputs.stylix.homeModules.stylix ];

  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  programs.home-manager.enable = true;

}
