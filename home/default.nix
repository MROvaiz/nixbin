{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    # "${self}/home/users/mro.nix" # user
    # "${self}/home/systems/core" # core configs
    # "${self}/home/systems/hyprland" # Hyprland configs
    # "${self}/home/systems/softwares" # Softwares
  ];
}
