# Optional: modded minecraft fabric server
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {
      test-server = {
        enable = true;
        autoStart = true;
        #package = pkgs.fabricServers.fabric-1_20_1;

        serverProperties = {
          server-port = 25565;
          white-list = true;
          max-players = 16;
          motd = "§k";

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
        };

        operators = {
          schpinkledorf = {
            uuid = "bbc70679-5257-483b-83d0-0bf1ebac4b4d";
            level = 4; # Owner
            bypassesPlayerLimit = true;
          };
        };

        # Fetch hosted modpack
        symlinks = let
          modpack = pkgs.fetchPackwizModpack {
            url = "https://github.com/EzraWolf/modpacks/blob/main/FrenchVanilla/pack.toml";
            packHash = "1c97e6c60b29d3a7e29a7607bb8aa2b2b698180886d60b701be34d84d976c1b6";
          };

          mcVersion = modpack.manifest.versions.minecraft;
          fabricVersion = modpack.manifest.versions.fabric;
          serverVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";
        in {
          package = pkgs.fabricServers.${serverVersion}.override {loaderVersion = fabricVersion;};
          "mods" = "${modpack}/mods";
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
