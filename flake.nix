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

  outputs = { self, nixpkgs, home-manager, illogical-impulse, ... }@inputs:
  let
    system = "x86_64-linux";
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;

      # make `inputs` visible inside modules and pass the dots flake into Home Manager
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix

        # Home Manager NixOS module + per-user HM configuration
        home-manager.nixosModules.home-manager
        {
          # allow user packages and set your user's home.nix
          home-manager.useUserPackages = true;
          home-manager.users.toshiba = import ./home.nix;

          # CRITICAL: pass the top-level flake inputs into HM so imports like
          # `inputs.illogical-impulse.homeManagerModules.default` and export sets
          # such as `hypr` become available inside home.nix
          home-manager.extraSpecialArgs = { inputs = inputs; };
        }
      ];
    };
  };
}
