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
  };

  outputs =
    { self
    , nixpkgs
    , ...
    } @ inputs:
    let
      system = "x86_64-linux";
      home-manager = inputs.home-manager;
      username = "mro";

      nixos-system = system-module:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self username; };
          modules = [
            system-module

            # Home Manager Config
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit username;
              };
              home-manager.users.${username} = {
                imports = [ (import ./nixos/users/mro) ];
              };
            }

          ];
        };
    in
    {
      nixosConfigurations = {
        nixbin = nixos-system ./machine/nixbin;
      };
    };
}
