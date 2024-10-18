{ config, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run,ssh,filebrowser,powermenu:${config.xdg.configHome}/generated/powermenu.lua";
      
      me-accept-entry = "MousePrimary";
      me-select-entry = "";
      show-icons = true;
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
    theme = "${config.xdg.configHome}/generated/rofi-theme.rasi";
  };

  home.file = {
    "${config.xdg.configHome}/generated/rofi-theme.rasi".text = let
      theme = import ../themes/current-theme.nix;
    in ''
      * {
        accent: #${theme.background1};
        bg: #${theme.background0};
        fg: #${theme.foreground};
        background-color: @bg;
        text-color: @fg;
        font: "RobotoMono Nerd Font 14";
      }
      
      element-text,
      element-icon,
      mode-switcher {
        background-color: inherit;
        text-color: inherit;
      }
      
      window {
        width: 648px;
        transparency: "real";
        border: 2px;
        border-color: @fg;
      }
      
      textbox-prompt-colon {
        padding: 8px 6px;
        border: 0 0 2px 0;
        border-color: @fg;
        str: "";
        expand: false;
      }
      
      
      entry {
        placeholder: "Search";
        placeholder-color: @fg;
        text-color: @fg;
        border: 0 0 2px 0;
        border-color: @fg;
        padding: 8px 2px;
        expand: true;
      }
      
      inputbar {
        children: [textbox-prompt-colon,entry];
        expand: false;
        spacing: 0;
        margin: 20px;
      }
      
      listview {
        background-color: @accent;
        columns: 1;
        lines: 7;
        spacing: 0;
        cycle: false;
        dynamic: true;
        layout: vertical;
        margin: 0 20px;
        border-radius: 5px;
        scrollbar: false;
      }
      
      mainbox {
        children: [inputbar,listview,mode-switcher];
      }
      
      element {
        orientation: horizontal;
        padding: 12px 24px;
        
        background-color: @accent;
      }
      
      element-text {
        expand: true;
        margin: 0 10px;
        
        background-color: inherit;
        text-color: inherit;
      }
      
      element selected {
        background-color: @fg;
        
        text-color: @bg;
        border-radius: 5px;
      }
      
      mode-switcher {
        background-color: @accent;
        spacing: 0;
        border-color: green;
        border-radius: 5px;
        margin: 20px;
      }
      
      button {
        padding: 15px;
        margin: 0;
        
        text-color: @fg;
        background-color: @accent;
      }
      
      button selected {
        padding: 8px;
        border-radius: 5px;
        text-color: @bg;
        background-color: @fg;
      }
    '';
    "${config.xdg.configHome}/generated/powermenu.lua" = {
      text = ''
        #!${pkgs.luajit}/bin/luajit
        
        -- Use a list because table keys are randomly sorted
        -- It's also easier to add options or edit them this way
        local options = {
          {
            name = "Sleep",
            icon = "system-suspend",
            command = "systemctl suspend"
          },
          {
            name = "Shut down",
            icon = "system-shutdown",
            command = "systemctl poweroff"
          },
          {
            name = "Restart",
            icon = "system-reboot",
            command = "systemctl reboot"
          },
          {
            name = "Lock",
            icon = "system-lock-screen",
            command = "swaylock"
          },
          {
            name = "Log out",
            icon = "system-log-out",
            command = "swaymsg exit"
          }
        }
        
        for i, opt in ipairs(options) do
          if arg[1] then
            if opt.name == arg[1] then
              os.execute(opt.command)
            end
          else
            print(opt.name..'\0icon\x1f'..opt.icon)
          end
        end
      '';
      executable = true;
    };
  };
}
