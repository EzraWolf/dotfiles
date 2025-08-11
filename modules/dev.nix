# Optional: development tools
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs_22 bun # LTS
    uv
    rustup
    go gotools
    ollama khoj
  ];
}
