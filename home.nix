{ config, pkgs, ... }:

{
  home.username = "zap";
  home.homeDirectory = "/home/zap";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./dev/configuration.nix
    ./apps/configuration.nix
    ./desktop/configuration.nix
  ];

  fonts.fontconfig.enable = true;

  home.file = {
    "${config.xdg.configHome}/res" = {
      source = ./res;
      recursive = true;
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
