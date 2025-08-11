{ config, lib, pkgs, vars, ... }:
{
  imports = [
    ../core/system.nix
    ../core/services.nix
    ../core/desktop.nix
  ] ++ lib.optional (builtins.pathExists ./hardware-configuration.nix) ./hardware-configuration.nix;

  # Basic NVIDIA driver setup
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;      # may disable if issues
    powerManagement.finegrained = true; # Turing+
    open = false;                       # use proprietary driver
    nvidiaSettings = true;              # nvidia-settings GUI
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };

  # Enable OpenGL / Vulkan
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true; # for Steam/Wine if needed
  };
}
