{
  config,
  pkgs,
  self,
  ...
}: {
  programs.git = {
    enable = true;
    userName = "MROvaiz";
    userEmail = "rahilovaiz@gmail.com";
  };
}
