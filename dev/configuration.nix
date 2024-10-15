{ config, pkgs, ... }:

{
  # Configure the development environment
  imports = [
    ./nvim.nix
    ./fish.nix
    ./zsh.nix
    ./bat.nix
    ./git.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    tokei
    htop

    # Everything else can be installed in nix-shells
  ];
}
