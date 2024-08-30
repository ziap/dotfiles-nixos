{ config, pkgs, ... }:

{
  # Configures GUI-based desktop apps
  imports = [
    ./firefox.nix
    ./mimeapps.nix
    ./zathura.nix
    ./imv.nix
  ];
}
