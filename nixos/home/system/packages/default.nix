{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    "${self}/nixos/home/system/packages/git.nix" # Git
  ];
}
