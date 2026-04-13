{ pkgs, lib, ... }:
{
  programs = {
    git = {
      enable = true;
      settings.user = {
        name = "bgl gwyng";
        email = "bgl@gwyng.com";
      };
    };
    difftastic = {
      enable = true;
      git.enable = true;
    };
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      autocd = true;
    };
    zsh.plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };

  home.file.".p10k.zsh".source = ./.p10k.zsh;

  home.shellAliases = {
    lg = "${pkgs.lazygit}";
    sync-nixpkgs = "nix flake update --override-input nixpkgs nixpkgs";
  };

  programs.zsh = {
    initContent = lib.mkMerge [
      (lib.mkBefore ''
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '')
      ''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

        autoload -U up-line-or-beginning-search down-line-or-beginning-search
        zle -N up-line-or-beginning-search
        zle -N down-line-or-beginning-search
        bindkey '^[[A' up-line-or-beginning-search
        bindkey '^[[B' down-line-or-beginning-search
        bindkey '^[OA' up-line-or-beginning-search
        bindkey '^[OB' down-line-or-beginning-search
      ''
    ];
  };

  services.ssh-agent = {
    enable = true;
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.11";
}
