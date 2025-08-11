# Defines all user accounts for the system.

{ pkgs, username, userdesc, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    description = userdesc; # Fixed: Corrected variable name
    extraGroups = [ "wheel" "docker" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
  };
  
  # Enable sudo for wheel group
  security.sudo.wheelNeedsPassword = false; # Optional: passwordless sudo
}
