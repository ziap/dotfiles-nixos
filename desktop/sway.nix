{ config, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    extraOptions = ["--unsupported-gpu"];
    config = let
      screenshotMode = "Screenshot: [s]creen [w]window [r]egion";
      mod = "Mod4";
      theme = import ../themes/current-theme.nix;
    in {
      output."*" = {
        "bg" = "${../res/wall-${theme.name}.png} fill";
      };

      # Layout
      window = {
        "border" = 2;
        "titlebar" = false; 
      };
      gaps = {
        "inner" = 6;
        "smartBorders" = "on";
      };
      floating = {
        "border" = 2;
        "titlebar" = false;
        "modifier" = "${mod}";
      };

      input = {
        "type:touchpad" = {
          "tap" = "enabled";
          "natural_scroll" = "enabled";
          "middle_emulation" = "enabled";
          "dwt" = "disabled";
        };

        # Set caps lock to ctrl
        "type:keyboard" = {
          "xkb_options" = "ctrl:nocaps";
        };

        # Disable touchscreen
        "type:touch" = {
          "events" = "disabled";
        };
      };

      defaultWorkspace = "workspace number 1";

      # Only use 2 colors to theme everything
      colors = let
        mkColor = bg: fg: {
          background = bg;
          border = bg;
          text = fg;
          indicator = bg;
          childBorder = bg;
        };
      in {
        "background" = "#${theme.background0}";
        "focused" = mkColor "#${theme.foreground}" "#${theme.background1}";
        "focusedInactive" = mkColor "#${theme.background1}" "#${theme.foreground}";
        "unfocused" = mkColor "#${theme.background1}" "#${theme.foreground}";
        "urgent" = mkColor "#${theme.regular1}" "#${theme.foreground}";
      };
      keybindings = let
        term = "${pkgs.kitty}/bin/kitty";

        rofi = "${pkgs.rofi-wayland}/bin/rofi";
        menu = "${rofi} -show drun | swaymsg";
        file = "${rofi} -show filebrowser | swaymsg";
        power = "${rofi} -show powermenu | swaymsg";

        lock = "${pkgs.swaylock}/bin/swaylock";

        browser = "${config.programs.firefox.finalPackage}/bin/firefox";
        privateBrowser = "${browser} --private-window";

        left = "h";
        right = "l";
        up = "k";
        down = "j";

        resizeFactor = "40px";

        pactl = "${pkgs.pulseaudio}/bin/pactl";
        playerctl = "${pkgs.playerctl}/bin/playerctl";
      in {
        # Application launching
        "${mod}+Return" = "exec ${term}";
        "${mod}+Shift+Return" = "exec ${menu}";
        "${mod}+w" = "kill";
        "${mod}+b" = "exec ${browser}";
        "${mod}+Shift+b" = "exec ${privateBrowser}";
        "${mod}+e" = "exec ${file}";
        "${mod}+q" = "exec ${power}";
        "${mod}+z" = "exec ${lock}";

        # Window controls
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

        # Layout stuffs
        "${mod}+f" = "fullscreen";
        "${mod}+Shift+space" = "floating toggle";
        "${mod}+space" = "focus mode_toggle";
        "${mod}+Shift+minus" = "move scratchpad";
        "${mod}+minus" = "scratchpad show";

        # Mutlimedia keys
        "--locked XF86MonBrightnessUp" = "exec light -A 5";
        "--locked XF86MonBrightnessDown" = "exec light -U 5";
      
        "--locked XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +5%";
        "--locked XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -5%";
        "--locked XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
        "--locked XF86AudioMicMute" = "exec ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle";
      
        "--locked XF86AudioPlay" = "exec ${playerctl} play-pause";
        "--locked XF86AudioNext" = "exec ${playerctl} next";
        "--locked XF86AudioPrev" = "exec ${playerctl} previous";
      
        # Mutimedia shortcuts
        "${mod}+p" = "exec ${playerctl} play-pause";
        "${mod}+Period" = "exec ${playerctl} next";
        "${mod}+Comma" = "exec ${playerctl} previous";

        # Take screenshot
        "--to-code ${mod}+s" = "mode \"${screenshotMode}\"";

        # Map 0 to workspace 10
        "${mod}+0" = "workspace number 10";
        "${mod}+Shift+0" = "move workspace number 10";
      } // builtins.listToAttrs (let
        # Move and switch to workspace 1 -> 9
        workspaces = map toString (pkgs.lib.range 1 9);

        keybindSwitch = map (x: {
          name = "${mod}+${x}";
          value = "workspace number ${x}";
        }) workspaces;

        keybindMove = map (x: {
          name = "${mod}+Shift+${x}";
          value = "move workspace number ${x}";
        }) workspaces;
      in keybindSwitch ++ keybindMove);

      modes = {
        # Maybe rofi is better in this case, but currently, I use a Sway mode
        # to take screenshots
        "${screenshotMode}" = let
          grim = "${pkgs.grim}/bin/grim";
          slurp = "${pkgs.slurp}/bin/slurp";
          wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
          jq = "${pkgs.jq}/bin/jq";

          # `pkgs.writer.writeDash` doesn't provide error checking for some
          # reason
          writer = pkgs.writers.makeScriptWriter {
            interpreter = "${pkgs.dash}/bin/dash";
            check = "${pkgs.dash}/bin/dash -n";
          };

          screenshot = writer "screenshot.sh" /*sh*/ ''
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
  };

  services.playerctld.enable = true;
}
