{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run,ssh,filebrowser,powermenu:${config.xdg.configHome}/res/powermenu.lua";
      
      me-accept-entry = "MousePrimary";
      me-select-entry = "";
      show-icons = true;
      icon-theme = "ePapirus";
      application-fallback-icon = "run-build";
      
      drun-display-format = " {name} ";
      run-shell-command = "foot {cmd}";
      ssh-command = "foot --term=xterm ssh {host}";
      sidebar-mode = true;
      matching = "fuzzy";
      scroll-method = 0;
      disable-history = false;

      display-drun = "󱓞 Apps";
      display-run = " Run";
      display-ssh = "󰀂 SSH";
      display-filebrowser = " Files";
      display-powermenu = " Power";

      combi-modi = "drun,run";
      sort = true;
      sorting-method = "fzf";
    };
    theme = "${config.xdg.configHome}/res/theme.rasi";
  };

  home.packages = with pkgs; [
    luajit
    epapirus-icon-theme
  ];
}
