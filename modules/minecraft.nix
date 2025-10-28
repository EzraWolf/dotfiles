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
