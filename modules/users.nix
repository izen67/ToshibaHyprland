{ config, pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.toshiba = {
    isNormalUser = true;
    description = "toshiba";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
