# Core user packages (daily essentials)
{
  pkgs,
  lib,
  vars,
  ...
}: {
  home.packages = with pkgs; [
    mpv
    zathura # Essential media tools
    signal-desktop
    thunderbird
    qbittorrent
    geany
    vscode
    neofetch
    bleachbit
  ];

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Noto Sans Mono";
      font_size = 14;
      confirm_os_window_close = 0;
      scrollback_lines = 16384;
      enable_audio_bell = false;
      background_opacity = lib.mkForce 0.8; # Some magical upstream bullshit keeps resetting this
    };
    keybindings = {
      "ctrl+c" = "copy_to_clipboard";
      "ctrl+v" = "paste_from_clipboard";
      "ctrl+t" = "new_tab";
      "ctrl+w" = "close_tab";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      vim_keys = true;
      proc_tree = true;
      show_gpu_info = "auto";
      show_uptime = true;
      show_coretemp = true;
      cpu_sensor = "auto";
      show_disks = true;
      only_physical = true;
    };
  };

  programs.firefox = {
    enable = true;
    profiles.${vars.username} = {
      settings = {
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        "security.tls.insecure_fallback_hosts" = "";
        "browser.tabs.warnOnClose" = false;
        "browser.urlbar.suggest.searches" = false;
      };
    };
  };
}
