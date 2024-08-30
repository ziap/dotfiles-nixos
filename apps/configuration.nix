{ config, pkgs, ... }:

{
  # Configures GUI-based desktop apps
  imports = [
    ./firefox.nix
    ./mimeapps.nix
    ./zathura.nix
    ./imv.nix
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
  };
}
