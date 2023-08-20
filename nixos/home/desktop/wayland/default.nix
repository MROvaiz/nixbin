{
  config,
  pkgs,
  self,
  ...
}: {
  # Wayland config
  imports = [
    ./hyprland
    ./waybar
    ./swayidle_lock
    ./themes
    # ./swaybg.nix
    # ./swww.nix
  ];

  home.packages = with pkgs; [
    # wallpaper
    swww
    # idle/lock
    swaylock-effects

    # utils and misc
    wf-recorder
    wl-clipboard
    wlogout
    hyprpicker
    wlsunset
    tree
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
    XCURSOR_SIZE = "18";
  };
}
