{ config, pkgs, ... }:

{
  # Configure the development environment
  imports = [
    ./fish.nix
    ./zsh.nix
    ./git.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    tokei
  ];
}
