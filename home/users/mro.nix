# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  config,
  pkgs,
  self,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mro = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
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
  };
}
