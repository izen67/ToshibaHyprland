# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs,  ... }:

{
  imports =
    [ # Include the results of the hardware scan.
     ./hardware-configuration.nix
     inputs.home-manager.nixosModules.default
     ./modules/extra/apps.nix
     ./modules/extra/system.nix
     ./modules/extra/desktop.nix
     ./modules/extra/gaming.nix
     ./modules/extra/network.nix
     inputs.illogical-impulse.homeManagerModules.default
    ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.05";

  home-manager = {
    # also pass inputs to home-manager modules
    extraSpecialArgs = {inherit inputs;};
    users = {
      "toshiba" = import ./home.nix;
    };
  };

}
