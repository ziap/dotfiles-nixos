{ config, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = let
      theme = import ../themes/current-theme.nix;
    in {
      ignore-empty-password = true;
      
      color = "${theme.background0}cd";
      indicator-radius = 80;
      indicator-thickness = 25;
      
      key-hl-color = "${theme.bright2}";
      bs-hl-color = "${theme.bright1}";
      
      separator-color = "${theme.background0}cd";
      
      line-color = "${theme.background0}";
      
      inside-color = "${theme.background0}";
      inside-clear-color = "${theme.bright3}";
      inside-ver-color = "${theme.bright4}";
      inside-wrong-color = "${theme.bright1}";
      
      ring-color = "${theme.bright0}";
      ring-ver-color = "${theme.regular4}";
      ring-clear-color = "${theme.regular3}";
      ring-wrong-color = "${theme.regular1}";

      text-color = "${theme.background0}";
      text-clear-color = "${theme.background0}";
      text-caps-lock-color = "${theme.background0}";
      text-ver-color = "${theme.background0}";
      text-wrong-color = "${theme.background0}";
    };
  };
}
