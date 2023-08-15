{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    "${self}/nixos/home/system/settings/virtmanager.nix" # Git
  ];
}
