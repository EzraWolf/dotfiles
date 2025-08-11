# Core system packages and configurations for them
{ pkgs, vars, ... }:

{
  # --- Essential System Packages ---
  environment.systemPackages = with pkgs; [
    # Core utilities
    wget
    curl
    nano      # Fallback for Helix
    helix     # Preferred simple editor when not using VSCode or similar
    pciutils  # For `lspci`
    file      # File type detection
    unzip
    zip
    p7zip     # Archive support (7zip backend)
    firefox
  ];

  # --- Docker Setup ---
  virtualisation.docker.enable = true;

  # --- ZSH Setup ---
  programs.zsh.enable = true;


  # --- Git Setup (System-wide defaults) ---
  programs.git = {
    enable = true;
    config = {
      init.defaultBranch = "main";
      push.default = "simple";
      credential.helper = "cache --timeout=7200";
      log.decorate = "full";
      log.date = "iso";
      merge.conflictStyle = "diff3";
    };
  };

  # --- Firefox Privacy Configuration ---
  programs.firefox = {
    enable = true;
    preferences = {
      # Privacy settings
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "privacy.trackingprotection.cryptomining.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
      
      # Disable telemetry
      "datareporting.healthreport.uploadEnabled" = false;
      "datareporting.policy.dataSubmissionEnabled" = false;
      "toolkit.telemetry.enabled" = false;
      "toolkit.telemetry.unified" = false;
      
      # Security
      "security.tls.insecure_fallback_hosts" = "";
      "security.tls.unrestricted_rc4_fallback" = false;
      
      # Disable pocket
      "extensions.pocket.enabled" = false;
      
      # Disable sponsored content
      "browser.newtabpage.activity-stream.showSponsored" = false;
      "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
    };
  };
}