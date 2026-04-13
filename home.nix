{ pkgs, lib, ... }:
{
  imports = [ ./zsh.nix ];

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
  };

  home.shellAliases = {
    lg = "${pkgs.lazygit}";
    sync-nixpkgs = "nix flake update --override-input nixpkgs nixpkgs";
  };

  services.ssh-agent = {
    enable = true;
  };

  # The state version is required and should stay at the version you
  # originally installed.
  home.stateVersion = "25.11";
}
