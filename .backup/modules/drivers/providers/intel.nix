# For the poor soul who has intel integrated graphics drivers. Me.
{ pkgs, ... }:

{
  # --- Intel Driver Configuration ---
  services.xserver.videoDrivers = [ "modesetting" ];

  # --- Hardware Graphics ---
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    
    extraPackages = with pkgs; [
      intel-media-driver  # VAAPI driver for newer Intel GPUs
      vaapiIntel          # VAAPI driver for older Intel GPUs
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
