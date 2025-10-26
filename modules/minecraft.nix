# Optional: modded minecraft fabric server
{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;
    servers.fabric = {
      package = pkgs.fabricServers.fabric-1_20_1.override {
        loaderVersion = "0.17.3";
      };

      symlinks = {
        mods = pkgs.linkFarmFromDrvs "mods" (
          builtins.attrValues {
            Fabric-API = pkgs.fetchurl {
              url = "";
              sha512 = "";
            };

            # More...
          }
        );
      };
    };
  };

  # home.packages = with pkgs; [ ];
}
