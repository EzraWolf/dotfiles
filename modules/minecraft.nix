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
    url = "https://raw.githubusercontent.com/EzraWolf/dotfiles/refs/heads/T2/minecraft/french-vanilla-server/pack.toml";
    packHash = "sha256-SNVI02zs6Kld4yh00996rldgsUxQFJEwLMiDzLAsKSM=";
  };

in {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {
      french-vanilla = {
        enable = true;
        autoStart = true;
        package = pkgs.fabricServers.fabric-1_20_1;

        serverProperties = {
          server-port = 25565;
          white-list = true;
          max-players = 16;
          motd = "Bruh";

          gamemode = "survival";
          difficulty = "normal";

          view-distance = 32;
          simulation-distance = 32;
        };

        whitelist = {
          schpinkledorf = "bbc70679-5257-483b-83d0-0bf1ebac4b4d";
          #  CHIEF__BEER
          #  josephus
          #  nxndr
          #  ServinVirgin (?)
        };

        operators = {
          schpinkledorf = {
            uuid = "bbc70679-5257-483b-83d0-0bf1ebac4b4d";
            level = 4; # Owner level
            bypassesPlayerLimit = true;
          };
        };

        # Fetch local modpack
        symlinks = {
          "mods" = "${modpack}/mods";
        };

        files = {
          "config" = "${modpack}/config";
          #"options.txt" = "${modpack}/options.txt";
        };

        jvmOpts = "-Xms4G -Xmx6G -XX:+UseG1GC";
      };

      open-vanilla = {
        enable = true;
        autoStart = true;
        package = pkgs.vanillaServers.vanilla-1_20_1;

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
