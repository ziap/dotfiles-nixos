{ config, pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    options = {
      selection-clipboard = "clipboard";

      font = "FiraCode Nerd Font 12";

      default-bg = "#282828";
      default-fg = "#ebdbb2";

      completion-bg = "#3c3836";
      completion-fg = "#ebdbb2";
      completion-highlight-bg = "#83a598";
      completion-highlight-fg = "#282828";
      completion-group-bg = "#3c3836";
      completion-group-fg = "#ebdbb2";
      
      statusbar-bg = "#3c3836";
      statusbar-fg = "#ebdbb2";
      
      inputbar-bg = "#3c3836";
      inputbar-fg = "#ebdbb2";
      
      notification-bg = "#3c3836";
      notification-fg = "#ebdbb2";
      notification-error-bg = "#3c3836";
      notification-error-fg = "#fb4934";
      notification-warning-bg = "#3c3836";
      notification-warning-fg = "#fabd2f";
      
      highlight-color = "#83a598";
      
      recolor = true;
      recolor-keephue = true;
      recolor-lightcolor = "#282828";
      recolor-darkcolor = "#ebdbb2" ;
    };
  };
}
