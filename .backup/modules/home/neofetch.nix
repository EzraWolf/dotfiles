# Neofetch configuration with af++ theme
# https://github.com/Chick2D/neofetch-themes/tree/main/small/af%2B%2B
{ pkgs, vars, ... }:

{
  # --- Neofetch Package ---
  home.packages = with pkgs; [ neofetch ];

  # --- Neofetch Configuration (af++ theme) ---
  home.file.".config/neofetch/config.conf".text = ''
    # https://github.com/chick2d/neofetch-themes
    print_info() {
        #info "\e[31m " users
        info "\e[32m " kernel
        info "\e[33m " uptime
        info "\e[34m " packages
        info "\e[35m " wm
        info "\e[32m " shell
        info "\e[33m " memory
    }

    # Shorten the output of the kernel function.
    kernel_shorthand="off"

    # Shorten the output of the distro function
    distro_shorthand="off"

    # Show/Hide OS Architecture.
    os_arch="off"

    # Shorten the output of the uptime function
    uptime_shorthand="on"

    # Show memory pecentage in output.
    memory_percent="off"

    # Change memory output unit ('kib', 'mib', 'gib')
    memory_unit="mib"

    # Show/Hide Package Manager names.
    # Values:  'on', 'tiny' 'off'
    # on:   '998 (pacman), 8 (flatpak), 4 (snap)'
    # tiny: '998 (pacman, flatpak, snap)'
    # off:  '998'
    package_managers="on"

    # Show the path to $SHELL
    # Example:
    # on:  '/bin/bash'
    # off: 'bash'
    shell_path="on"

    # Show $SHELL version
    shell_version="on"

    # Display refresh rate next to each monitor
    refresh_rate="off"

    # Show Desktop Environment version
    de_version="on"

    # Text Colors
    # Values:   'distro', 'num' 'num' 'num' 'num' 'num' 'num'
    # Each number represents a different part of the text in
    # this order: 'title', '@', 'underline', 'subtitle', 'colon', 'info'
    # Example:
    # colors=(distro)      - Text is colored based on Distro colors.
    # colors=(4 6 1 8 8 6) - Text is colored in the order above.
    colors=(4 7 4 7 7)

    # Toggle bold text
    bold="on"

    # Enable/Disable Underline
    underline_enabled="on"

    # Underline character (string)
    underline_char="-"

    # Info Separator
    # Replace the default separator with something else.
    separator=":"

    # Color block range
    # The range of colors to print.
    # Start color
    block_range=(0 15)

    # Toggle color blocks
    color_blocks="on"

    # Color block width in spaces
    block_width=3

    # Color block height in lines
    block_height=1

    # Color Alignment
    # Values: 'auto', 'num'
    col_offset="auto"

    # Progress Bars
    # Which bars to display.
    # Values:  'distro', 'host', 'kernel', 'uptime', 'packages', 'shell',
    #          'resolution', 'de', 'wm', 'wm_theme', 'theme', 'icons', 'terminal',
    #          'terminal_font', 'cpu', 'gpu', 'memory', 'gpu_driver', 'cpu_usage',
    #          'disk', 'battery', 'font', 'song', 'local_ip', 'public_ip', 'locale'
    bar_char_elapsed="-"
    bar_char_total="="
    bar_border="on"
    bar_length=15
    bar_color_elapsed="distro"
    bar_color_total="distro"

    # Display a bar with the info.
    cpu_display="off"
    memory_display="off"
    battery_display="off"
    disk_display="off"

    # Backend Settings
    # Image backend.
    image_backend="ascii"

    # Image Source
    image_source="auto"

    # Ascii Options
    # Ascii distro
    ascii_distro="auto"

    # Ascii Colors
    ascii_colors=(distro)

    # Bold ascii logo
    ascii_bold="on"

    # Image Options
    # Image loop
    image_loop="off"

    # Thumbnail directory
    thumbnail_dir="''${XDG_CACHE_HOME:-''${HOME}/.cache}/thumbnails/neofetch"

    # Crop mode
    crop_mode="normal"

    # Crop offset
    crop_offset="center"

    # Image size
    image_size="auto"

    # Gap between image and text
    gap=3

    # Image offsets
    yoffset=0
    xoffset=0

    # Image background color
    background_color=

    # Misc Options
    # Stdout mode
    stdout="off"
  '';

  # --- Custom ASCII Art (af++ theme) ---
  home.file.".config/neofetch/ascii.txt".text = ''
 ▄       ▄
▄ ▀▄   ▄▀ ▄
█▄█▀███▀█▄█
▀█████████▀
 ▄▀     ▀▄ 
  '';
}
