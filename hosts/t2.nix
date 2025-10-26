# NOTE: Running `nixos-generate-config` may NOT work as intended since this is
#       constantly battling the T2 security chip.
#       Best action is to just NEVER touch anything hardware related.
{
  config,
  lib,
  pkgs,
  vars,
  ...
}: {
  imports =
    [
      ../core/system.nix
      ../core/services.nix
      ../core/desktop.nix

      # TODO: Make own copy of this branch in case it ever goes missing.
      # "${builtins.fetchGit { url = "https://github.com/kekrby/nixos-hardware.git"; }}/apple/t2"
    ]
    ++ lib.optional (builtins.pathExists ./hardware-t2.nix) ./hardware-t2.nix;

  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  # Mac T2 firmware magic. DO NOT TOUCH.
  hardware.firmware = [
    (pkgs.stdenvNoCC.mkDerivation {
      name = "brcm-firmware";
      buildCommand = ''
        dir="$out/lib/firmware"
        mkdir -p "$dir"
        cp -r ${./t2-firmware}/* "$dir"
      '';
    })
  ];
}
