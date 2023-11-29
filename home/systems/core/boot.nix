{
  config,
  pkgs,
  self,
  ...
}: {
  # Implements Grub for EFI machines.
  boot.loader = {
    efi = {
      # canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      devices = ["nodev"];
      efiInstallAsRemovable = true;
      efiSupport = true;
      useOSProber = true;
      timeoutStyle = "hidden";
    };
  };
}
