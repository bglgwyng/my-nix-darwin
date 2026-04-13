{ pkgs, ... }:
{
  fonts.packages = [
    (pkgs.fetchzip {
      url = "https://github.com/y-kim/monoplex/releases/download/v0.0.2/MonoplexKR-v0.0.2.zip";
      stripRoot = false;
      hash = "sha256-gGmFrXrMUosTTFKLq20BETa3yUEyhFKA2h7UC8pFmWE=";
    })
  ];
  home-manager.users.bglgwyng.programs = {
    ghostty.settings.font-family = "Monoplex KR Nerd";
  };
}
