# Defines system-wide security settings.
{ ... }:

{
  # --- Polkit ---
  security.polkit.enable = true;

  # --- PAM ---
  security.pam.services.swaylock = {};

  # --- Firewall ---
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  # --- Real-Time Kit for Audio ---
  # NOTE: Also enabled inside of `./modules/drivers/audio.nix`
  security.rtkit.enable = true;
}

