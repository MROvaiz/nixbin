{ config, pkgs, username, ... }:
{
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "22.05";
  };
  programs = {
    home-manager.enable = true;
  };
}