# Custom shell script commands
{ vars, ... }:

{
  # --- Zsh Configuration ---
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # Oh My Zsh
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "git" "docker" "sudo" ];
    };
    
    # Shell aliases
    shellAliases = {
      # Basic aliases
      ll = "ls -alF";
      la = "ls -A";
      l = "ls -CF";
      grep = "grep --color=auto";
      ".." = "cd ..";
      "..." = "cd ../..";
      
      # NixOS specific aliases
      rebuild = "sudo nixos-rebuild switch";
      rebuild-test = "sudo nixos-rebuild test";
      nix-search = "nix search nixpkgs";
      nix-shell = "nix-shell --run zsh";
      
      # System utilities
      btop = "btop";
      neofetch = "neofetch";
      
      # Git shortcuts
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";
      
      # Archive shortcuts (using 7zip backend)
      extract = "file-roller";
      compress = "file-roller";
    };
    
    # Additional shell configuration
    initContent = ''
      # Custom prompt with hostname
      export PS1="%F{green}%n@${vars.userhost}%f:%F{blue}%~%f$ "
      
      # Environment variables
      export EDITOR="${vars.default_editor}"
      export BROWSER="${vars.default_browser}"
      export TERMINAL="${vars.default_terminal}"
      
      # XDG directories
      export XDG_CONFIG_HOME="$HOME/.config"
      export XDG_DATA_HOME="$HOME/.local/share"
      export XDG_CACHE_HOME="$HOME/.cache"
      
      # Development environment
      export CARGO_HOME="$HOME/.cargo"
      export RUSTUP_HOME="$HOME/.rustup"
      
      # Add cargo bin to PATH if it exists
      [ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"
    '';
    
    # History configuration
    history = {
      size = 16384;
      save = 16384;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
  };

  # --- Git User Configuration ---
  programs.git = {
    enable = true;
    userName = vars.gitusername;
    userEmail = vars.gitemail;
    
    extraConfig = {
      init.defaultBranch = "main";
      push.default = "simple";
      credential.helper = "cache --timeout=7200";
      log.decorate = "full";
      log.date = "iso";
      merge.conflictStyle = "diff3";
      pull.rebase = false;
    };
    
    aliases = {
      br = "branch --sort=-committerdate";
      co = "checkout";
      df = "diff";
      com = "commit -a";
      st = "status";
      lg = "log --graph --pretty=format:'%Cred%h%Creset - %C(yellow)%d%Creset %s %C(green)(%cr)%C(bold blue) <%an>%Creset' --abbrev-commit";
    };
  };
}
