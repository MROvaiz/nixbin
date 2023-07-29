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
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    nixos-system = system-module:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit self;};
        modules = [
          system-module
        ];
      };
  in {
    nixosConfigurations = {
      nixbin = nixos-system ./machine/nixbin;
    };
  };
}
