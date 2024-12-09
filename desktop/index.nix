{ config, pkgs, ... }:

{
  # Configure essential programs for the desktop environment
  imports = [
    ./kitty.nix
    ./rofi.nix
    ./sway.nix
    ./swaylock.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.roboto-mono
    nerd-fonts.victor-mono
  ];
}
