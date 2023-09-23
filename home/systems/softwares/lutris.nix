{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
  ];
  environment.variables = {
    MESA_GL_VERSION_OVERRIDE = "4.5";
  };
}
