{ config, pkgs, ... }:

{
  # Configure the development environment
  imports = [
    ./nvim/index.nix
    ./fish.nix
    ./zsh.nix
    ./nushell.nix
    ./bat.nix
    ./eza.nix
    ./git.nix
    ./starship.nix
  ];

  # Use Neovim to view manpages
  home.sessionVariables = {
    MANPAGER = "${config.programs.neovim.finalPackage}/bin/nvim +Man!";
  };

  # Essential packages to enable but not worth its own module
  home.packages = with pkgs; [
    fd ripgrep skim
    tokei htop

    clang
    # Everything else can be installed in development shells
  ];
}
