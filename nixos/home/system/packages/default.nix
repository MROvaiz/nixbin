{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./git.nix # Git
    ./kodi.nix # Kodi
  ];
  home.packages = with pkgs; [
    obsidian
    unrar
    obs-studio
    ani-cli
  ];
}
