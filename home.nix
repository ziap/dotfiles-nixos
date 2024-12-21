{ config, pkgs, ... }:

{
  home = let 
    username = "zap";
  in {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.11";
  };

  imports = [
    ./dev/index.nix
    ./apps/index.nix
    ./desktop/index.nix
  ];

  fonts.fontconfig.enable = true;
}
