{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    self.inputs.hyprland.homeManagerModules.default
    ./config.nix
  ];

  # enable hyprland
  wayland.windowManager.hyprland.enable = true;
}
