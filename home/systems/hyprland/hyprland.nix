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
  environment.sessionVariables = {
    # Hint electronic apps to use wayland
    NIXOS_OZONE_WL = "1";
  };
}
