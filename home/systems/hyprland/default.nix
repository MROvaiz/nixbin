{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    # "${self}/home/systems/hyprland/hyprland.nix" # Hyprland
    "${self}/home/systems/hyprland/thunar.nix" # Thunar
    "${self}/home/systems/hyprland/waybar.nix" # Waybar
  ];
}
