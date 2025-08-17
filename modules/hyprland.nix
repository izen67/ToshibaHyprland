{ config, pkgs, ... }:

{
# Hyprland at system level
programs.hyprland.enable = true;

# Required for permissions dialogs
security.polkit.enable = true;

# Audio stack
services.pipewire = {
  enable = true;
  alsa.enable = true;
  pulse.enable = true;
  wireplumber.enable = true;
};

# XDG portals so Wayland apps work correctly under Hyprland
xdg.portal = {
  enable = true;
  wlr.enable = true;
  extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
};

# OpenGL stack
hardware.opengl.enable = true;

# Optional: a simple login that starts Hyprland for your user
# If you already enable SDDM/GDM in modules/kde.nix, disable them there to avoid conflicts.
services.greetd = {
  enable = true;
  settings.default_session = { command = "Hyprland"; user = "toshiba"; };
};
}
