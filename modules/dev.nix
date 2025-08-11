# Optional: development tools
{pkgs, ...}: {
  home.packages = with pkgs; [
    nodejs_22 # LTS, nodejs_24 is the latest though.
    bun
    uv
    go
    gotools
    ollama
    open-webui # `khoj` is currently broken...
  ];
}
