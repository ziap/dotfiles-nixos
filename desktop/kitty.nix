{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = let
      theme = import ../themes/current-theme.nix;
    in {
      font_family             = "FiraCode Nerd Font";
      bold_font               = "family='FiraCode Nerd Font', style='Bold'";
      italic_font             = "family='VictorMono Nerd Font' style='SemiBold Italic'";
      bold_italic_font        = "family='VictorMono Nerd Font' style='Bold Italic'";
      font_size               = 14;
      disable_ligatures       = "never";
      remember_window_size    = "no";
      initial_window_width    = "100c";
      initial_window_height   = "36c";
      confirm_os_window_close = 0;
      input_delay             = 0;

      shell                   = "fish";

      url_color               = "#${theme.bright4}";
      visual_bell_color       = "#${theme.bright6}";
      bell_border_color       = "#${theme.bright6}";
      active_border_color     = "#${theme.bright5}";
      inactive_border_color   = "#${theme.background2}";
      background              = "#${theme.background0}";
      foreground              = "#${theme.foreground}";
      selection_foreground    = "#${theme.bright0}";
      selection_background    = "#${theme.bright7}";
      active_tab_foreground   = "#${theme.foreground}";
      active_tab_background   = "#${theme.background2}";
      inactive_tab_foreground = "#${theme.regular7}";
      inactive_tab_background = "#${theme.background1}";
      color0                  = "#${theme.regular0}";
      color1                  = "#${theme.regular1}";
      color2                  = "#${theme.regular2}";
      color3                  = "#${theme.regular3}";
      color4                  = "#${theme.regular4}";
      color5                  = "#${theme.regular5}";
      color6                  = "#${theme.regular6}";
      color7                  = "#${theme.regular7}";
      color8                  = "#${theme.bright0}";
      color9                  = "#${theme.bright1}";
      color10                 = "#${theme.bright2}";
      color11                 = "#${theme.bright3}";
      color12                 = "#${theme.bright4}";
      color13                 = "#${theme.bright5}";
      color14                 = "#${theme.bright6}";
      color15                 = "#${theme.bright7}";

      cursor                  = "#${theme.bright0}";
      cursor_text_color       = "background";
      cursor_trail            = 3;
      cursor_trail_decay      = "0.1 0.3";
    };
  };
}
