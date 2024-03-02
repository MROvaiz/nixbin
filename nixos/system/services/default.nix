{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [];
  services.vnstat.enable = true;
  services.hardware.openrgb.enable = true;
}
