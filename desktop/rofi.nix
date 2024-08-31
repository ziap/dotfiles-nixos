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
    theme = "${config.xdg.configHome}/res/rofi-theme.rasi";
  };

  home.packages = with pkgs; [
    epapirus-icon-theme
  ];

  home.file = {
    "${config.xdg.configHome}/generated/powermenu.lua" = {
      text = let
        lock = "${pkgs.swaylock}/bin/swaylock";
        logout = "${pkgs.sway}/bin/swaymsg exit";
        luajit = "${pkgs.luajit}/bin/luajit";
      in ''
        #!${luajit}
        
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
            command = "${lock}"
          },
          {
            name = "Log out",
            icon = "system-log-out",
            command = "${logout}"
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
