{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    "${self}/nixos/system/packages/git.nix" # Git
  ];
}
