{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [];
  environment.systemPackages = [
    pkgs.ncdu
  ];
}
