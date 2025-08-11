# NOTE: Run `nixos-generate-config` to create create the hardware-configuration.nix file
#       then copy it here and rename it to `hardware-<your_target>.nix` to use it
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
    ]
    ++ lib.optional (builtins.pathExists ./hardware-desktop.nix) ./hardware-desktop.nix;

  # --- NVIDIA Driver Configuration ---
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Use the open source version for RTX 20 series and newer
    # Set to false for older cards (GTX 10 series and older)
    open = true;

    # Enable the Nvidia settings menu
    nvidiaSettings = true;

    # Select the appropriate driver version
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Enable power management (experimental)
    powerManagement.enable = false;
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module
    modesetting.enable = true;
  };

  # --- Hardware Graphics ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # --- Kernel Parameters ---
  boot.kernelParams = ["nvidia_drm.modeset=1"];
}
