{ ... }:

{
  imports = [
    # Common drivers (always enabled)
    ./audio.nix
    ./bluetooth.nix
    ./printing.nix
    
    # GPU providers are imported in host-specific configs
    # DO NOT IMPORT THEM HERE.
    # ./providers/nvidia.nix     # Import in desktop/configuration.nix
    # ./providers/amd.nix        # Import in desktop/configuration.nix
    # ./providers/intel.nix      # Import in laptop/configuration.nix
  ];
}

