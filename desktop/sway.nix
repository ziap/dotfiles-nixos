{ config, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    extraOptions = ["--unsupported-gpu"];
    config = let
      screenshotMode = "Screenshot: [s]creen [w]window [r]egion";
      mod = "Mod4";
    in {
      output."*" = {
        "bg" = "${config.xdg.configHome}/res/wallpaper.png fill";
      };
      gaps = {
        "inner" = 6;
        "smartBorders" = "on";
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
      defaultWorkspace = "workspace number 1";
      window = {
        "border" = 2;
        "titlebar" = false; 
      };
      floating = {
        "border" = 2;
        "titlebar" = false;
        "modifier" = "${mod}";
      };
      colors = let
        mkColor = bg: fg: {
          background = bg;
          border = bg;
          text = fg;
          indicator = bg;
          childBorder = bg;
        };
      in {
        "background" = "#282828";
        "focused" = mkColor "#ebdbb2" "#3c3836";
        "focusedInactive" = mkColor "#3c3836" "#ebdbb2";
        "unfocused" = mkColor "#3c3836" "#ebdbb2";
        "urgent" = mkColor "#cc241d" "#ebdbb2";
      };
      keybindings = let
        term = "footclient";
        menu = "rofi -show drun | swaymsg";
        file = "rofi -show filebrowser | swaymsg";
        power = "rofi -show powermenu | swaymsg";
        lock = "swaylock";
        browser = "firefox";
        privateBrowser = "firefox --private-window";

        left = "h";
        right = "l";
        up = "k";
        down = "j";

        workspaces = ["1" "2" "3" "4" "5" "6" "7" "8" "9" "10"];
        resizeFactor = "40px";

        light = "light";
        pactl = "${pkgs.pulseaudio}/bin/pactl";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
      in {
        "${mod}+Return" = "exec ${term}";
        "${mod}+Shift+Return" = "exec ${menu}";
        "${mod}+w" = "kill";
        "${mod}+b" = "exec ${browser}";
        "${mod}+Shift+b" = "exec ${privateBrowser}";
        "${mod}+e" = "exec ${file}";
        "${mod}+q" = "exec ${power}";
        "${mod}+z" = "exec ${lock}";

        "${mod}+${left}" = "focus left";
        "${mod}+${down}" = "focus down";
        "${mod}+${up}" = "focus up";
        "${mod}+${right}" = "focus right";

        "${mod}+Shift+${left}" = "move left";
        "${mod}+Shift+${down}" = "move down";
        "${mod}+Shift+${up}" = "move up";
        "${mod}+Shift+${right}" = "move right";

        "${mod}+Ctrl+${left}" = "resize shrink width ${resizeFactor}";
        "${mod}+Ctrl+${down}" = "resize grow height ${resizeFactor}";
        "${mod}+Ctrl+${up}" = "resize shrink height ${resizeFactor}";
        "${mod}+Ctrl+${right}" = "resize grow width ${resizeFactor}";

        "${mod}+f" = "fullscreen";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+a" = "focus parent";
        "${mod}+Shift+minus" = "move scratchpad";
        "${mod}+minus" = "scratchpad show";

        "--locked XF86MonBrightnessUp" = "exec ${light} -A 5";
        "--locked XF86MonBrightnessDown" = "exec ${light} -U 5";
      
        "--locked XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
        "--locked XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";
        "--locked XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
        "--locked XF86AudioMicMute" = "exec ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle";
      
        "--locked XF86AudioPlay" = "exec ${playerctl} play-pause";
        "--locked XF86AudioNext" = "exec ${playerctl} next";
        "--locked XF86AudioPrev" = "exec ${playerctl} previous";
      
        "${mod}+p" = "exec ${playerctl} play-pause";
        "${mod}+Period" = "exec ${playerctl} next";
        "${mod}+Comma" = "exec ${playerctl} previous";

        "--to-code ${mod}+s" = "mode \"${screenshotMode}\"";
      }
      // builtins.listToAttrs (map (x: let k = if x == "10" then "0" else x; in {
        name = "${mod}+${k}";
        value = "workspace number ${x}";
      }) workspaces)
      // builtins.listToAttrs (map (x: let k = if x == "10" then "0" else x; in {
        name = "${mod}+Shift+${k}";
        value = "move workspace number ${x}";
      }) workspaces);

      modes = {
        "${screenshotMode}" = let
          screenshot = "${config.xdg.configHome}/generated/screenshot.sh";
        in {
          "--to-code s" = "mode \"default\", exec ${screenshot} screen";
          "--to-code w" = "mode \"default\", exec ${screenshot} window";
          "--to-code r" = "mode \"default\", exec ${screenshot} region";

          "--to-code Return" = "mode \"default\"";
          "--to-code Escape" = "mode \"default\"";
        };
      };

      bars = [
        { command = "waybar"; }
      ];
    };

    checkConfig = false;
  };

  services.playerctld.enable = true;

  home.file = {
    "${config.xdg.configHome}/generated/screenshot.sh" = {
      text = let
        grim = "${pkgs.grim}/bin/grim";
        slurp = "${pkgs.slurp}/bin/slurp";
        wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
        jq = "${pkgs.jq}/bin/jq";
      in ''
        #!/bin/sh

        case $1 in
          screen) ${grim} - | ${wl-copy};;
          region) ${grim} -g "$(${slurp})" - | ${wl-copy};;
          window) ${grim} -g "$(
            $swaymsg -t get_tree \
              | ${jq} -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' \
              | ${slurp}
          )" - | ${wl-copy};;
        esac
      '';
      executable = true;
    };
  };
}
