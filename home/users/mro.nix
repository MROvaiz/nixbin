# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).
{
  config,
  pkgs,
  self,
  ...
}: {
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
