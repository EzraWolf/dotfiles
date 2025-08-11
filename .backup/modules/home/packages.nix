# Defines core packages for your USER environment via Home Manager.
{ pkgs, vars, ... }:

{
  # --- Core User Applications ---
  home.packages = with pkgs; [
    # --- Wayland Desktop Environment ---
    waybar        # Status bar
    wofi          # App launcher
    dunst         # Notification daemon
    swaybg        # Wallpaper manager
    wl-clipboard  # Wayland clipboard tools
    kdePackages.polkit-kde-agent-1 # Auth agent for password prompts

    # --- File Management ---
    xfce.thunar        # File manager
    file-roller   # Archive manager GUI (uses p7zip backend from /core/)

    # TEMPORARY
    vscode

    # --- Media & Documents ---
    imv           # Image viewer
    mpv           # Video player
    zathura       # PDF viewer

    # --- Screenshots & Recording ---
    grim          # Screenshot capture tool
    slurp         # Region selector for screenshots
    wf-recorder   # Screen recording

    # --- System Utilities ---
    neofetch      # System information
    lxappearance  # GTK theme selector
    pavucontrol   # Audio control GUI
    brightnessctl # Screen brightness control
    playerctl     # Media player control
  ];

  # --- BTOP Setup ---
  programs.btop = {
    enable = true;
    package = pkgs.btop.override {
      rocmSupport = true;
      cudaSupport = true;
    };
    settings = {
      vim_keys = true;
      proc_tree = true;
      show_gpu_info = "on";
      show_uptime = true;
      show_coretemp = true;
      cpu_sensor = "auto";
      show_disks = true;
      only_physical = true;
      io_mode = true;
      io_graph_combined = false;
    };
  };

  # --- Kitty Terminal Configuration ---
  programs.kitty = {
    enable = true;
    settings = {
      # Font configuration (Noto Sans Mono)
      font_family = "Noto Sans Mono";
      font_size = 14;
      
      # Window settings
      confirm_os_window_close = 0;
      scrollback_lines = 16384;
      enable_audio_bell = false;
      enabled_layouts = "splits";
      window_padding_width = 8;
      background_opacity = 0.9;
      
      # Color scheme (dark theme)
      background = "#1e1e1e";
      foreground = "#d4d4d4";
      cursor = "#d4d4d4";
      
      # Tab settings
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
    };
    
    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
      "ctrl+shift+t" = "new_tab";
      "ctrl+shift+w" = "close_tab";
      "ctrl+shift+right" = "next_tab";
      "ctrl+shift+left" = "previous_tab";
      "ctrl+shift+enter" = "new_window";
    };
  };

  # --- Zathura PDF Viewer Configuration ---
  programs.zathura = {
    enable = true;
    options = {
      # Dark theme
      default-bg = "#1e1e1e";
      default-fg = "#d4d4d4";
      statusbar-bg = "#2d2d2d";
      statusbar-fg = "#d4d4d4";
      inputbar-bg = "#2d2d2d";
      inputbar-fg = "#d4d4d4";
      
      # Behavior
      adjust-open = "best-fit";
      pages-per-row = 1;
      scroll-page-aware = true;
      scroll-full-overlap = "0.01";
      scroll-step = 50;
      zoom-min = 10;
      guioptions = "none";
    };
  };

  # --- MPV Video Player Configuration ---
  programs.mpv = {
    enable = true;
    config = {
      # Video settings
      hwdec = "auto-safe";
      vo = "gpu";
      profile = "gpu-hq";
      
      # Audio settings
      audio-display = false;
      
      # Behavior
      keep-open = true;
      save-position-on-quit = true;
      
      # OSD
      osd-level = 1;
      osd-duration = 2000;
    };
  };

  # --- Firefox User Configuration ---
  # NOTE: Firefox is setup inside of `/core/packages.nix`
  #       but this is sets up USER configs - NOT system
  programs.firefox = {
    enable = true;
    profiles.${vars.username} = {
      settings = {
        # Startup
        "browser.startup.homepage" = "about:blank";
        "browser.newtabpage.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        
        # Privacy
        "privacy.trackingprotection.enabled" = true;
        "privacy.donottrackheader.enabled" = true;
        
        # Security
        "security.tls.insecure_fallback_hosts" = "";
        
        # UI
        "browser.tabs.warnOnClose" = false;
        "browser.urlbar.suggest.searches" = false;
      };
    };
  };
}
