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
    packHash = "sha256-sbVfcqB8SnuCrxJoDgL8DRGym/z0D4kLkJz19GUgjvg=";
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
          server-port = 6502;
          white-list = true;
          max-players = 8;
          motd = "Bruh";
          level-seed = "8147278618533048915";

          gamemode = "survival";
          difficulty = "normal";

          view-distance = 16;
          simulation-distance = 16;
        };

        whitelist = {
          a = "bbc70679-5257-483b-83d0-0bf1ebac4b4d";
          b = "1d88520f-c694-4d8c-995c-14493e168431";
          c = "6bb02585-a970-4206-89f6-0654a4600736";
          d = "76e4f93b-6d75-4dc1-9bb1-a43feaffb94d";
          e = "7f2bd047-3516-43ec-967d-48bb5e535519";
          f = "2852ae6e-c099-43de-8aab-995638ead7de";
          g = "9a2b04c0-d631-4bc8-8ae4-64dc770468e8";
          h = "72967380-6fcb-4afd-9074-c241b1c4d11d";
          i = "7bcab96d-c7ec-4d81-914a-5e9a5504cf3d";
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

        jvmOpts = "-Xms6G -Xmx6G -XX:+UseG1GC";
      };

      vanilla = {
        enable = false;
        autoStart = true;
        package = pkgs.vanillaServers.vanilla-1_20_1;

        serverProperties = {
          server-port = 8822;
          white-list = true;

          gamemode = "survival";
          difficulty = "normal";

          motd = "That Vanilla Pack";
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

        jvmOpts = "-Xms4G -Xmx4G -XX:+UseG1GC";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    packwiz
  ];
}
