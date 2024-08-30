{ config, pkgs, ... }:

{
  # Configure essential programs for the desktop environment
  imports = [
    ./foot.nix
    ./rofi.nix
  ];

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "RobotoMono" "VictorMono" ]; })
    htop neofetch
  ];
}