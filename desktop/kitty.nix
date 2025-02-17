{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    keybindings = let
      mod = "ctrl+shift";
    in {
      "${mod}+enter" = "new_window_with_cwd";
      "${mod}+m"     = "move_window_to_top";
      "${mod}+j"     = "next_window";
      "${mod}+k"     = "previous_window";

      "${mod}+t" = "new_tab_with_cwd";
      "${mod}+l" = "next_tab";
      "${mod}+h" = "previous_tab";
      "${mod}+q" = "close_tab";

      "${mod}+p" = "remote_control scroll-window 0.5p-";
      "${mod}+n" = "remote_control scroll-window 0.5p+";

      "${mod}+c" = "copy_to_clipboard";
      "${mod}+v" = "paste_from_clipboard";

      "${mod}+f" = "next_layout";
    };
    settings = let
      theme = import ../themes/current-theme.nix;
    in {
      # Clear keybindings
      clear_all_shortcuts = "yes";

      # Font configuration
      font_family       = "FiraCode Nerd Font";
      bold_font         = "family='FiraCode Nerd Font', style='Bold'";
      italic_font       = "family='VictorMono Nerd Font' style='SemiBold Italic'";
      bold_italic_font  = "family='VictorMono Nerd Font' style='Bold Italic'";
      font_size         = 14;
      disable_ligatures = "never";

      # Windowing
      remember_window_size    = "no";
      initial_window_width    = "100c";
      initial_window_height   = "36c";
      confirm_os_window_close = 2;

      # Other configuration
      input_delay     = 0;
      shell           = "fish";
      enabled_layouts = "tall:bias=56,fat:bias=72";

      # Theming
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

      # Tab bar
      tab_bar_edge  = "top";
      tab_bar_style = "powerline";

      # Cursor configuration
      cursor                       = "#${theme.bright0}";
      cursor_text_color            = "background";
      cursor_trail                 = 3;
      cursor_trail_decay           = "0.1 0.3";
      cursor_trail_start_threshold = 1;
    };
  };
}
