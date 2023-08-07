{
  config,
  pkgs,
  self,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
