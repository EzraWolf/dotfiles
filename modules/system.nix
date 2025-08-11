# Core system packages (essential, minimal but robust)
{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nano helix      # Essential editors
    gcc make uv     # Essential build tools
    alejandra
    gnupg openssl   # Essential security
    git
    zsh
    curl wget
    man-db tldr
    pciutils        # For `lspci`
    p7zip
    zbar
    file fd ncdu
    apcalc bc fzf
    xclip
    uutils-coreutils-noprefix
    gparted veracrypt ventoy
    bleachbit
    flameshot
  ];

  virtualisation.docker.enable = true;
}
