
# This is the central hub.
# It defines global variables and assembles core modules
# alongside setting up the home manager.
#
# `/modules/core`     defines common system setups
# `/modules/home`     defines user setups
# `/modules/packages` defines optional package bundles by use-case (e.g., productivity.nix)
{ config, pkgs, lib, ... }:

let
  # Define custom variables properly
  username = "z80";
  userhost = "zx-spectrum";
  userdesc = "This is my system. There are many like it, but this one is mine.";
  
  # Import Home Manager for NixOS 25.05
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz";
in
{
  imports = [
    # Import Home Manager NixOS module
    (import "${home-manager}/nixos")
    
    # Import all core system modules
    ../modules/core
  ];

  # Make variables available to other modules via specialArgs
  _module.args = {
    inherit username userhost userdesc;
    vars = {
      inherit username userhost userdesc;
      userhome = "/home/${username}";
      
      modifier = "SUPER";

      gitusername = username;
      gitemail = ""; # TODO: Set your email here

      # Timezone & Locale
      timezone = "America/New_York";
      locale = "en_US.UTF-8";
      time24h = true;
      keyboardmap = "us";
      consolemap = "us";

      # Defaults
      default_terminal = "kitty";
      default_editor = "hx"; # Helix as default, nano also works.
      default_browser = "firefox";
      default_display_mgr = "sddm";
    };
  };

  # Home Manager Configuration
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";

    # Pass variables to Home Manager
    extraSpecialArgs = { 
      inherit username userhost userdesc;
      inherit (config._module.args) vars;
    };
    
    users.${username} = {
      imports = [
        # Import user-specific modules
        ../modules/home
        
        # Import optional package bundles
        ../modules/packages
      ];
      
      # Required for Home Manager
      home.stateVersion = "25.05";
    };
  };
}
