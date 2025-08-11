# Core system packages (essential, minimal but robust)
{
  pkgs,
  vars,
  ...
}: {
  environment.systemPackages = with pkgs; [
    # Essential editors
    nano
    helix

    # Essential build tools
    gcc
    cmake
    uv
    rustup
    alejandra

    # Essential utilities
    gnupg
    openssl
    curl
    wget
    man-db
    tldr
    pciutils # For `lspci`
    p7zip
    zbar
    file
    fd
    ncdu
    bc
    fzf
    xclip
    uutils-coreutils-noprefix
    gparted
    veracrypt
    ventoy # Ventoy is technically "unsafe" since it uses blobs.
    flameshot
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-1.1.05"
  ];

  programs.git = {
    enable = true;
    config = {
      user.name = vars.gituser;
      user.email = vars.gitmail;
    };
  };

  programs.zsh.enable = true;
  virtualisation.docker.enable = true;

}
