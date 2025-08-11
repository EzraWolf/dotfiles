# Fixed packages/default.nix - Optional package bundles
{ ... }:

{
  # This file can be used to conditionally enable package bundles
  # For now, individual bundles are imported directly in common.nix
  # Future: Add options to enable/disable specific bundles
  
  imports = [
    # Individual bundles are imported in common.nix as needed
    ./productivity.nix  # Imported in common.nix
    # ./engineering.nix   # Future bundle
    ./gaming.nix        # Future bundle
  ];
}

