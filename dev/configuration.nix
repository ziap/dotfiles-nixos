{ config, pkgs, ... }:

{
  # Configure the development environment
  imports = [
    ./zsh.nix
    ./git.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    tokei
  ];
}
