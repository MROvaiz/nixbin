{
  description = "flake for MROvaiz Config";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    hyprwm-contrib.url = "github:hyprwm/contrib";

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    vscode-server.url = "github:nix-community/nixos-vscode-server";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    nixos-system = system-module: hostName: username: monitor:
      nixpkgs.lib.nixosSystem {
        inherit system;
        # special Args passing
        specialArgs = {
          inherit self username;
          host = {
            hostName = hostName;
            mainMonitor = monitor;
          };
        };

        modules = [
          # TODO add default/common modules

          # host specific module for now
          system-module

          # Home Manager Config
          home-manager.nixosModules.home-manager
          {
            # use system packages
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # special Args passing
            home-manager.extraSpecialArgs = {
              inherit self username;
              host = {
                hostName = hostName;
                monitor = monitor;
              };
            };
            # start home manager user
            home-manager.users.${username} = {
              # home manager modules
              imports = [
                ./nixos/users/${username}
              ];
            };
          }
        ];
      };
  in {
    nixosConfigurations = {
      # function module_name hostname username monitor_name
      nixbin = nixos-system ./nixos/machine/nixbin "nixbin" "mro" "DP-1";

      # TODO The format will follow same and hardware few packages differ.
      # nixwork = nixos-system ./nixos/machine/nixwork "nixwork" "mro" "HDMI-A-1";
    };
  };
}
