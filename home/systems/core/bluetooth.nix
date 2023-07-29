{
  config,
  pkgs,
  self,
  ...
}: {
  # Enable Bluetooth.
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
}
