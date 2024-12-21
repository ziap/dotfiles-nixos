{ config, pkgs, ... }:

{
  # Configure the development environment
  imports = [
    ./nvim/index.nix
    ./fish.nix
    ./zsh.nix
    ./nushell.nix
    ./bat.nix
    ./git.nix
    ./starship.nix
  ];

  home.sessionVariables = {
    MANPAGER = "nvim +Man!";
  };

  home.packages = with pkgs; [
    eza fd ripgrep skim
    tokei htop

    clang
    # Everything else can be installed in development shells
  ];
}
