# Desktop environment window manager configuration
{ vars, ... }:

{
  # --- Hyprland Configuration ---
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # --- Monitor Setup ---
      monitor = ",preferred,auto,1";

      # --- Autostart Applications ---
      exec-once = [
        "waybar"
        "dunst"
        "pkill swaybg; swaybg -c '#FDFBF8'" # Murder this bitch because it keeps trying to piss me off
        "polkit-kde-agent"
      ];

      # --- General Settings ---
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        "col.active_border" = "rgba(bd93f9ff) rgba(ff79c6ff) 45deg";
        "col.inactive_border" = "rgba(44475aff)";
        layout = "dwindle";
        resize_on_border = true;  # Resize by dragging borders
        extend_border_grab_area = 15; # Easier border grabbing
      };

      # --- Disable tiling behaviors ---
      dwindle = {
        pseudotile = false;
        preserve_split = false;
        smart_split = true;
        smart_resizing = false;
        force_split = 0;
      };

      # --- Misc settings ---
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        new_window_takes_over_fullscreen = 2;
        windowrulev2 = [
          "float, class:.*"
          "size 800 600, class:.*"
        ];
      };

      # --- Decoration ---
      decoration = {
        rounding = 2;
        blur = {
          enabled = false;
          size = 3;
          passes = 1;
        };
      };

      # --- Animations ---
      animations = {
        enabled = false;
        # enabled = true;
        #bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        #animation = [
        #  "windows, 1, 7, myBezier"
        #  "windowsOut, 1, 7, default, popin 80%"
        #  "border, 1, 10, default"
        #  "borderangle, 1, 8, default"
        #  "fade, 1, 7, default"
        #  "workspaces, 1, 6, default"
        #];
      };

      # --- Input Settings ---
      input = {
        kb_layout = vars.keyboardmap;
        follow_mouse = 1;
        touchpad = {
          natural_scroll = false;
        };
        sensitivity = 0;
      };

      # --- Keybindings ---
      bind = [
        # --- Application Launchers ---
        "${vars.modifier}, RETURN, exec, ${vars.default_terminal}"
        "${vars.modifier}, SPACE, exec, wofi --show drun"
        "${vars.modifier}, E, exec, thunar"
        "${vars.modifier}, F, exec, ${vars.default_browser}"

        # --- Window Management ---
        "${vars.modifier}, Q, killactive,"
        "${vars.modifier}, M, exit,"
        "${vars.modifier}, V, togglefloating,"
        "${vars.modifier}, P, pseudo,"
        "${vars.modifier}, J, togglesplit,"
        "F11, , fullscreen,"

        # --- Move Focus & Windows ---
        "${vars.modifier}, left, movefocus, l"
        "${vars.modifier}, right, movefocus, r"
        "${vars.modifier}, up, movefocus, u"
        "${vars.modifier}, down, movefocus, d"
        "${vars.modifier} SHIFT, up, movewindow, u"
        "${vars.modifier} SHIFT, right, movewindow, r"
        "${vars.modifier} SHIFT, down, movewindow, d"
        "${vars.modifier} SHIFT, left, movewindow, l"

         # --- Manual tiling ---
        "${vars.modifier} Control_L, left, resizeactive, -50% 0"   # Make window take left half
        "${vars.modifier} Control_L, right, resizeactive, 50% 0"   # Make window take right half
        "${vars.modifier} Control_L, up, resizeactive, 0 -50%"     # Make window take top half
        "${vars.modifier} Control_L, down, resizeactive, 0 50%"    # Make window take bottom half

        

        # --- Switch Workspaces ---
        "${vars.modifier}, 1, workspace, 1"
        "${vars.modifier}, 2, workspace, 2"
        "${vars.modifier}, 3, workspace, 3"
        "${vars.modifier}, 4, workspace, 4"
        "${vars.modifier}, 5, workspace, 5"

        # --- Move Window to Workspace ---
        "${vars.modifier} SHIFT, 1, movetoworkspace, 1"
        "${vars.modifier} SHIFT, 2, movetoworkspace, 2"
        "${vars.modifier} SHIFT, 3, movetoworkspace, 3"
        "${vars.modifier} SHIFT, 4, movetoworkspace, 4"
        "${vars.modifier} SHIFT, 5, movetoworkspace, 5"

        # --- Screenshots ---
        ", Print, exec, grim -g \"$(slurp)\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"
        "SHIFT, Print, exec, grim ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"

        # --- Media Keys ---
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Execute after release
      #bindr = [
      #  "${vars.modifier}, SUPER_L, exec, wofi --show drun"
      #];

      # --- Mouse Bindings ---
      bindm = [
        "${vars.modifier}, mouse:272, movewindow"
        "${vars.modifier}, mouse:273, resizewindow"
        # "${vars.modifier}, mouse:272, resizewindow"
      ];
    };
  };

  # --- Waybar Configuration ---
  programs.waybar = {
    enable = true;
    style = ''
      * {
        font-family: "Noto Sans", "Symbols Nerd Font";
        font-size: 14px;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 30, 0.9);
        color: #ffffff;
        border-bottom: 2px solid #bd93f9;
      }

      #workspaces button {
        padding: 0 8px;
        background: transparent;
        color: #ffffff;
        border-bottom: 2px solid transparent;
      }

      #workspaces button.active {
        background: #bd93f9;
        border-bottom: 2px solid #ff79c6;
      }

      #clock, #pulseaudio, #network, #tray {
        padding: 0 10px;
        margin: 0 5px;
        background: rgba(68, 71, 90, 0.8);
        border-radius: 5px;
      }
    '';

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = [ "hyprland/workspaces" "hyprland/window" ];
        modules-center = [ "clock" ];
        modules-right = [ "tray" "pulseaudio" "network" ];

        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "󰲠";
            "2" = "󰲢";
            "3" = "󰲤";
            "4" = "󰲦";
            "5" = "󰲨";
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 50;
        };

        clock = {
          format = " {:%H:%M}";
          format-alt = " {:%Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 Muted";
          format-icons = {
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pavucontrol";
        };

        network = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀 Connected";
          format-disconnected = "󰤭 Disconnected";
          tooltip-format = "{ifname}: {ipaddr}";
        };

        tray = {
          icon-size = 16;
          spacing = 10;
        };
      };
    };
  };
}
