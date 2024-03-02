{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [];
  services.vnstat.enable = true;
  services.hardware.openrgb.enable = true;
  # Enable Bluetooth.
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
