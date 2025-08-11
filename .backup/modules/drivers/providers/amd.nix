# Enables open-source drivers for AMD GPUs.
{ pkgs, ... }:

{
  # --- AMD Driver Configuration ---
  services.xserver.videoDrivers = [ "amdgpu" ];

  # --- Hardware Graphics ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    
    extraPackages = with pkgs; [
      rocmPackages.clr.icd  # AMD OpenCL
      amdvlk                # AMD Vulkan
    ];
    
    extraPackages32 = with pkgs.pkgsi686Linux; [
      amdvlk
    ];
  };

  # --- Kernel Parameters ---
  boot.kernelParams = [ "amdgpu.dc=1" ];
}
