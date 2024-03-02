{
  config,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./packages # Packages
    ./services # Services
    ./configs # Configs
  ];
  programs.fuse.userAllowOther = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mro = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "fuse"
      "libvirtd"
      # "docker"
    ]; # Enable ‘sudo’ for the user.
  };
}
