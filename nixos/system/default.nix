{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./containers # Containers
    ./packages # Packages
  ];
  programs.fuse.userAllowOther = true;
}
