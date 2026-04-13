{
  description = "My nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
    }:
    let
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = with pkgs; [
            nil
            nixd
            nixpkgs-fmt
            nix-tree
            #
            # git
            difftastic
            lazygit
            #
            nodejs_24
            node-gyp
            gcc
            clang
            pnpm
            #
            zed-editor
            #
            wireguard-tools
            #
            ghostty-bin
            #
            devenv
          ];

          nix = {
            enable = true;
            settings.experimental-features = [
              "nix-command"
              "flakes"
            ];
            registry = {
              nixpkgs.flake = nixpkgs;
            };
          };

          nixpkgs.config.allowBroken = true;

          programs.direnv = {
            enable = true;
            nix-direnv.enable = true;
          };

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # The platform the configuration will be used on.
          nixpkgs.hostPlatform = "aarch64-darwin";
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#default
      darwinConfigurations.default = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          {
            users.users.bglgwyng = {
              name = "bglgwyng";
              home = "/Users/bglgwyng";
            };
          }
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.bglgwyng = ./modules/home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
}
