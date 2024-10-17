{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "FiraCode Nerd Font:pixelsize=18";
	font-italic = "VictorMono Nerd Font:style=SemiBold Italic:pixelsize=18";
        initial-window-size-chars = "80x32";
      };
      colors = let
        theme = import ../themes/current-theme.nix;
      in {
        background = "${theme.background0}";
        foreground = "${theme.foreground}";
        
        regular0 = "${theme.regular0}";
        regular1 = "${theme.regular1}";
        regular2 = "${theme.regular2}";
        regular3 = "${theme.regular3}";
        regular4 = "${theme.regular4}";
        regular5 = "${theme.regular5}";
        regular6 = "${theme.regular6}";
        regular7 = "${theme.regular7}";

        bright0 = "${theme.bright0}";
        bright1 = "${theme.bright1}";
        bright2 = "${theme.bright2}";
        bright3 = "${theme.bright3}";
        bright4 = "${theme.bright4}";
        bright5 = "${theme.bright5}";
        bright6 = "${theme.bright6}";
        bright7 = "${theme.bright7}";
      };
      cursor = {
        beam-thickness = 1;
      };
    };
  };
}
