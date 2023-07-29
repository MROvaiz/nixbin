{
  config,
  pkgs,
  self,
  ...
}: {
  environment.systemPackages = with pkgs; [
    (lutris.override {
      extraLibraries = pkgs: [
        # List library dependencies here
      ];
      extraPkgs = pkgs: [
        wine
        # List package dependencies here
      ];
    })
  ];
}
