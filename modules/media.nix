# Optional: media tools
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    discord
    spotify
    foliate
    kiwix
    kiwix-tools
  ];

  # Jellyfin is typically self-hosted (docker); leave as service docs or compose.
}
