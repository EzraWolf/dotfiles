# Defines custom user keybinds

{ lib, ... }:

let
  # Shortcut to our global variables
  vars = lib.custom.vars;
  # Define the modifier key (Windows key)
  modifier = vars.modifier;
in
[
  # --- Application Launchers ---
  "${modifier}, T, exec, ${vars.default_terminal}" # Launch terminal
  # TODO: Add a package for an app launcher (like rofi) and bind it here.
  # "${modifier}, D, exec, rofi -show drun"

  # --- Window Management ---
  "${modifier}, Q, killactive,"          # Kill focused window
  "${modifier}, M, exit,"                # Exit Hyprland session
  "${modifier}, F, togglefloating,"      # Toggle floating for a window
  "${modifier}, P, pseudo,"              # Toggle pseudotiling
  "${modifier}, J, togglesplit,"         # Toggle split direction

  # --- Move Focus ---
  "${modifier}, left, movefocus, l"
  "${modifier}, right, movefocus, r"
  "${modifier}, up, movefocus, u"
  "${modifier}, down, movefocus, d"

  # --- Switch Workspaces ---
  "${modifier}, 1, workspace, 1"
  "${modifier}, 2, workspace, 2"
  "${modifier}, 3, workspace, 3"
  "${modifier}, 4, workspace, 4"
  "${modifier}, 5, workspace, 5"

  # --- Move Window to Workspace ---
  "${modifier} SHIFT, 1, movetoworkspace, 1"
  "${modifier} SHIFT, 2, movetoworkspace, 2"
  "${modifier} SHIFT, 3, movetoworkspace, 3"
  "${modifier} SHIFT, 4, movetoworkspace, 4"
  "${modifier} SHIFT, 5, movetoworkspace, 5"
]
