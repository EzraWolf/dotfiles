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
    packHash = "sha256-OPQF6N/knln1DBVpG6vdctOWvHwwgjn07mEoXUv+Z1A=";
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

          view-distance = 10;
          simulation-distance = 10;
        };

        whitelist = {
          a = "bbc70679-5257-483b-83d0-0bf1ebac4b4d";
          b = "1d88520f-c694-4d8c-995c-14493e168431";
          c = "6bb02585-a970-4206-89f6-0654a4600736";
          d = "76e4f93b-6d75-4dc1-9bb1-a43feaffb94d";
          e = "7f2bd047-3516-43ec-967d-48bb5e535519";
          f = "2852ae6e-c099-43de-8aab-995638ead7de";
          g = "9a2b04c0-d631-4bc8-8ae4-64dc770468e8";
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
          # "options.txt" = "${modpack}/options.txt";
        };

        jvmOpts = "-Xms4G -Xmx4G -XX:+UseG1GC";
      };

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
