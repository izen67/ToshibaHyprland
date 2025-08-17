{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # end-4 dots for NixOS (QuickShell variant)
    illogical-impulse = {
      url = "github:xBLACKICEx/end-4-dots-hyprland-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, illogical-impulse, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      # make `inputs` visible inside all modules
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix

        # Home-Manager as a NixOS module (import it here, not again in configuration.nix)
        home-manager.nixosModules.default
      ];
    };
  };
}
