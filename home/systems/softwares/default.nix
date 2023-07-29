{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    "${self}/home/systems/softwares/firefox.nix" # Firefox
    "${self}/home/systems/softwares/lutris.nix" # Lutris
    "${self}/home/systems/softwares/steam.nix" # Steam
  ];
}
