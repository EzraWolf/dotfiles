{
  description = "Test NixOS config (modular, LXQt, Stylix-ready)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    stylix,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    vars = {
      username = "z80";
      computer = "zx-spectrum";
      userhost = "desktop";
      userpath = "/home/z80/nixos-config";

      version = "25.05";

      gituser = vars.username;
      gitmail = "${vars.username}@example.com";

      locale = "en_US.UTF-8";
      timezone = "America/New_York";
      keyboardmap = "us";
      time24h = true;

      # Enable optional package modules (grouped by use case)
      # NOTE: system.nix and user.nix packages are always included
      enableDev = true;
      enableGaming = true;
      enableMedia = false;
      enableProductivity = false;
      enableSecurity = false;
    };
  in {
    nixosConfigurations.${vars.userhost} = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs vars;};
      modules = [
        ./hosts/${vars.userhost}.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = {inherit vars inputs;};
          home-manager.users.${vars.username} = import ./core/home.nix;
        }
        stylix.nixosModules.stylix
      ];
    };
  };
}
