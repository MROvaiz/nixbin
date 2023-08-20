{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./jellyfin.nix # Rclone Service
  ];
}
