{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    # ./docker.nix
  ];
  environment.systemPackages = with pkgs; [
    ncdu
    neofetch
    transmission-qt
  ];
}
