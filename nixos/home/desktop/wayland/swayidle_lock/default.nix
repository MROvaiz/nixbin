{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./swaylock.nix
    # ./swayidle.nix
  ];

  home.packages = with pkgs; [
    # idle/lock
    swaylock-effects
  ];
}
