{ config, pkgs, inputs, ... }:

let
  # resolve the flake's package set for the current system
  illogicalPkgs = inputs.illogical-impulse.packages.${pkgs.system};
in
{
  home.username = "toshiba";
  home.homeDirectory = "/home/toshiba";

  imports = [
    inputs.illogical-impulse.homeManagerModules.default
  ];

  illogical-impulse = {
    enable = true;

    hyprland = {
      # Explicitly use the package set exported by the dots flake
      package = illogicalPkgs.hypr.hyprland;
      xdgPortalPackage = illogicalPkgs.hypr.xdg-desktop-portal-hyprland;

      ozoneWayland.enable = true;
    };

    dotfiles = {
      fish.enable = true;
      kitty.enable = true;
    };
  };

  programs.fish.enable = true;
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
