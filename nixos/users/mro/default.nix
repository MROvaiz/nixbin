{
  config,
  pkgs,
  username,
  self,
  ...
}: {
  imports = [
    "${self}/nixos/desktop/wayland"
    "${self}/nixos/system/packages"
  ];
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "22.05";
  };
  programs = {
    home-manager.enable = true;
  };

  home.packages = with pkgs; [
    # editor
    vscode

    # misc
    tree

    # hyprland required
    kitty # terminal
    hyprpaper # wallpaper
    rofi-wayland # rofi

    # screenshot
    self.inputs.hyprwm-contrib.packages.${system}.grimblast # Screenshots.
    slurp

    # notifications
    dunst
    libnotify
  ];
}
