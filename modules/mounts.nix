{ config, pkgs, ... }:

{

  #to allow ntfs drive to get mounted, otherwise error:
  boot.supportedFilesystems = [ "ntfs" ];


  environment.systemPackages = with pkgs; [
    ntfs3g
    exfatprogs
    cifs-utils
  ];

}
