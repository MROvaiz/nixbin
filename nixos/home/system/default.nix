{
  config,
  pkgs,
  self,
  ...
}: {
  # System config
  imports = [
    ./packages
    ./settings
    ./services
  ];
}
