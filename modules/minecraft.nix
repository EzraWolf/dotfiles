# Optional: modded minecraft fabric server
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: let

  inherit (inputs.nix-minecraft.lib) fetchPackwizModpack;

  modpack = fetchPackwizModpack {
    url = "https://github.com/EzraWolf/modpacks/blob/0b714574a7155e552af1ebc4015a5d4bfceb9ea9/pack.toml";
    packHash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAa=";
  };

  mcVersion = modpack.manifest.versions.minecraft;
  fabricVersion = modpack.manifest.versions.fabric;
  serverVersion = lib.replaceStrings ["."] ["_"] "fabric-${mcVersion}";
in {
  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.fabric-server = {
      enable = true;
      autoStart = true;

      package = pkgs.fabricServer.${serverVersion}.override {
        loaderVersion = fabricVersion;
      };

      serverProperties = {
        server-port = 25565;
        gamemode = "survival";
        motd = "French Vanilla";
        max-player = 16;
        white-list = true;
      };

      whitelist = {
        PresentBusiness = "bbc70679-5257-483b-83d0-0bf1ebac4b4d";
        #  CHIEF__BEER
        #  josephus
        #  nxndr
      };

      ops = {
        PresentBusiness = {
          uuid = "bbc70679-5257-483b-83d0-0bf1ebac4b4d";
          level = 4;
          bypassesPlayerLimit = true;
        };
      };

      jvmOpts = "-Xms4G -Xmx6G -XX:+UseG1GC";

      symlinks = {"mods" = "${modpack}/mods";};

      files = {"config" = "${modpack}/config";};
    };
  };

  home.packages = with pkgs; [
    packwiz
  ];
}
