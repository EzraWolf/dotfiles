{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  # Import core user packages and optional feature modules as desired
  imports =
    [
      ../modules/user.nix
    ]
    ++ lib.optionals vars.enableMedia [../modules/media.nix]
    ++ lib.optionals vars.enableProductivity [../modules/productivity.nix]
    ++ lib.optionals vars.enableDev [../modules/dev.nix]
    ++ lib.optionals vars.enableGaming [../modules/gaming.nix]
    ++ lib.optionals vars.enableSecurity [../modules/security.nix]
    ++ lib.optionals vars.enableMinecraft [../modules/minecraft.nix];

  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";

  programs.home-manager.enable = true;

  home.stateVersion = vars.version;
}
