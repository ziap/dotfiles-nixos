{ config, pkgs, ... }: let
  kittyConfig = pkgs.writeTextDir "kitty.conf" /*conf*/ ''
active_border_color #D3869B
active_tab_background #504945
active_tab_foreground #EBDBB2
background #282828
bell_border_color #8EC07C
bold_font family='FiraCode Nerd Font', style='Bold'
bold_italic_font family='VictorMono Nerd Font' style='Bold Italic'
clear_all_shortcuts yes
color0 #282828
color1 #CC241D
color10 #B8BB26
color11 #FABD2F
color12 #83A598
color13 #D3869B
color14 #8EC07C
color15 #EBDBB2
color2 #98971A
color3 #D79921
color4 #458588
color5 #B16286
color6 #689D6A
color7 #A89984
color8 #928374
color9 #FB4934
confirm_os_window_close 2
cursor #928374
cursor_text_color background
cursor_trail 3
cursor_trail_decay 0.1 0.3
cursor_trail_start_threshold 1
disable_ligatures never
enabled_layouts tall:bias=56,fat:bias=72
font_family FiraCode Nerd Font
font_size 14
foreground #EBDBB2
inactive_border_color #504945
inactive_tab_background #3C3836
inactive_tab_foreground #A89984
initial_window_height 36c
initial_window_width 100c
input_delay 0
italic_font family='VictorMono Nerd Font' style='SemiBold Italic'
remember_window_size no
selection_background #EBDBB2
selection_foreground #928374
shell fish
tab_bar_edge top
tab_bar_style powerline
url_color #83A598
visual_bell_color #8EC07C


map ctrl+shift+0 change_font_size all 0
map ctrl+shift+c copy_to_clipboard
map ctrl+shift+enter new_window_with_cwd
map ctrl+shift+equal change_font_size all +2.0
map ctrl+shift+f next_layout
map ctrl+shift+h previous_tab
map ctrl+shift+j next_window
map ctrl+shift+k previous_window
map ctrl+shift+kp_add change_font_size all +2.0
map ctrl+shift+kp_subtract change_font_size all -2.0
map ctrl+shift+l next_tab
map ctrl+shift+m move_window_to_top
map ctrl+shift+minus change_font_size all -2.0
map ctrl+shift+n remote_control scroll-window 0.5p+
map ctrl+shift+p remote_control scroll-window 0.5p-
map ctrl+shift+plus change_font_size all +2.0
map ctrl+shift+q close_tab
map ctrl+shift+t new_tab_with_cwd
map ctrl+shift+v paste_from_clipboard
  '';
in {
  environment.sessionVariables = {
    KITTY_CONFIG_DIRECTORY = kittyConfig;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.victor-mono
  ];
}
