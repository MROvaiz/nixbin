{
  config,
  pkgs,
  self,
  ...
}: {
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    self.inputs.alejandra.defaultPackage.${system}
    zip
    unzip
    magic-wormhole
    btop
  ];
}
