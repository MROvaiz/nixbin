{
  config,
  pkgs,
  username,
  self,
  ...
}: {
  imports = [
    "${self}/nixos/home/desktop/wayland"
    "${self}/nixos/home/system/packages"
    "${self}/nixos/home/system/settings"
    "${self}/nixos/home/system/services"
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

    discord

    # misc
    tree

    # hyprland required
    kitty # terminal
    # hyprpaper # wallpaper
    rofi-wayland # rofi

    # screenshot
    self.inputs.hyprwm-contrib.packages.${system}.grimblast # Screenshots.
    grim
    slurp
    swappy

    # notifications
    dunst
    libnotify
  ];
}
