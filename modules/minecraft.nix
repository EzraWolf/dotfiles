# Optional: modded minecraft fabric server
{
  config,
  pkgs,
  inputs,
  lib,
  vars,
  ...
}: let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://raw.githubusercontent.com/EzraWolf/dotfiles/refs/heads/T2/minecraft/test/pack.toml";
    packHash = "sha256-Hb9FPwORyfmM+8jd5a2i1czVPyYMsvu9i0y4d/XqmDQ=";
  };
in {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {

      vanilla = {
        enable = true;
        autoStart = true;
        package = pkgs.vanillaServers.vanilla-1_20_1;

        whitelist = {
          schpinkledorf = "bbc70679-5257-483b-83d0-0bf1ebac4b4d";
          #  CHIEF__BEER
          #  josephus
          #  nxndr
          #  ServinVirgin (?)
        };

        serverProperties = {
          server-port = 25566;
        };

        jvmOpts = "-Xms4G -Xmx6G -XX:+UseG1GC";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    packwiz
  ];
}
