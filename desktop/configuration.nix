{ config, pkgs, ... }:

{
  # Configure essential programs for the desktop environment
  imports = [
    ./foot.nix
  ];

  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "VictorMono" ]; })
    htop neofetch
  ];
}
