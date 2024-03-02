{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    "${self}/home/systems/core/bluetooth.nix" # Bluetooth
    "${self}/home/systems/core/boot.nix" # Boot
    "${self}/home/systems/core/extra.nix" # Extra packages
    "${self}/home/systems/core/fonts.nix" # Fonts
    "${self}/home/systems/core/network.nix" # Network Config
    "${self}/home/systems/core/nix.nix" # Nix Settings
    "${self}/home/systems/core/sound.nix" # Sound Config
    "${self}/home/systems/core/videoDriver.nix" # Video Driver
    self.inputs.nixos-hardware.nixosModules.common-gpu-amd # AMD Driver
    "${self}/home/systems/core/virtmanager.nix" # Virt Manager
    "${self}/home/systems/core/vscode_server.nix" #vscode server
  ];
  security = {
    # allow wayland lockers to unlock the screen
    pam.services.swaylock.text = "auth include login";
  };
}
