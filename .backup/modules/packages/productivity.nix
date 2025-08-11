# Fixed productivity.nix - Productivity applications bundle
{ pkgs, ... }:

{
  # --- Productivity Applications ---
  home.packages = with pkgs; [
    # Note-taking and knowledge management
    obsidian
    vscode
    spotify
    
    # Future productivity apps can be added here:
    # thunderbird    # Email client
    # libreoffice    # Office suite
    # calendar apps, etc.
  ];
  
  # --- Obsidian Configuration ---
  # Note: Obsidian stores its config in ~/.config/obsidian/
  # You can manage vaults and settings through the application
}

