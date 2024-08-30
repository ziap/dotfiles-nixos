{ config, pkgs, ... }:

{
  home.username = "zap";
  home.homeDirectory = "/home/zap";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ./dev/configuration.nix
    ./apps/configuration.nix
    ./desktop/configuration.nix
  ];

  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      output."*" = {
        bg = "${config.xdg.configHome}/res/wallpaper.png fill";
      };
      gaps = {
        inner = 6;
        smartBorders = "on";
      };
      input = {
        "type:touchpad" = {
          "tap" = "enabled";
          "natural_scroll" = "enabled";
          "middle_emulation" = "enabled";
          "dwt" = "disabled";
        };

        "type:keyboard" = {
          "xkb_options" = "ctrl:nocaps";
        };

        "type:touch" = {
          "events" = "disabled";
        };
      };
    };
    checkConfig = false;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  fonts.fontconfig.enable = true;

  home.file = {
    "${config.xdg.configHome}/res" = {
      source = ./res;
      recursive = true;
    };
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
