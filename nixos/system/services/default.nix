{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [];
  services.vnstat.enable = true;
}
