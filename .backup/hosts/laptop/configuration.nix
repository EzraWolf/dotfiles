# This is the main entrypoint for the laptop. It's very simple:
# it just imports the hardware configuration and the common configuration.

{ ... }:

{
  imports = [
    ./hardware.nix
    ../common.nix # This pulls in all the shared settings

    # --- DRIVER SELECTION ---
    # Uncomment ONE of the following lines to select your GPU driver (if applicable)
    # ../../modules/drivers/providers/amd.nix
    # ../../modules/drivers/providers/nvidia.nix
    # ../../modules/drivers/providers/intel.nix
  ];

  # Laptop-specific configurations
  # Add any other laptop-only settings here if needed
  
  # System state version
  system.stateVersion = "25.05";
}
