{
  config,
  pkgs,
  self,
  ...
}: {
  programs.firefox = {
    enable = true;
  };
}
