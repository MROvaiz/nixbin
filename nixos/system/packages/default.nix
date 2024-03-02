{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    # ./docker.nix
    # vscode-server
    self.inputs.vscode-server.nixosModules.default
  ];
  environment.systemPackages = with pkgs; [
    ncdu
    neofetch
    transmission-qt

    # Lutris Setup
    (lutris.override {
      extraLibraries = pkgs: [
        # List library dependencies here
      ];
      extraPkgs = pkgs: [
        # List package dependencies here
        wineWowPackages.stableFull
        libgudev
        libvdpau
        libsoup
        libusb1
      ];
    })

    # Extra
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    self.inputs.alejandra.defaultPackage.${system}
    zip
    unzip
    magic-wormhole
    btop
  ];

  # Lutris Setup
  environment.variables = {
    MESA_GL_VERSION_OVERRIDE = "4.5";
  };
  # Enable Steam Game
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # Enable Thunar
  programs.thunar.enable = true;
  # Enable Firefox
  programs.firefox = {
    enable = true;
  };
  # Enable Git
  programs.git.enable = true;
  #  Enable vscode-server
  services.vscode-server.enable = true;
}
