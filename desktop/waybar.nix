{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    settings = [
      {
        modules-left = [ "sway/workspaces" "sway/window" "sway/mode" ];
        modules-right = [ "pulseaudio" "backlight" "network" "battery" "clock" ];
        clock = {
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format = "{:%b %d(%H:%M) 󰃰}";
        };
        backlight = {
          format = "{percent}% {icon}";
          format-icons = [ "" "" "" "" "" "" "" "" "" ];
          on-scroll-up = "light -A 1";
          on-scroll-down = "light -U 1";
        };
        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-charging = "{capacity}% 󰢝";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [ "" "" "" "" "" ];
        };
        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = "󰝟 {icon} {format_source}";
          format-muted = "󰝟 {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            headphone = "";
            hands-free = "󱠰";
            headset = "󰋎";
            phone = "";
            portable = "";
            car = "";
            default = [ "" "" "" ];
          };
          on-click = "${pkgs.pavucontrol}/bin/pavucontrol";
        };
        network = {
          format = "{ifname}";
          format-wifi = "Connected ";
          format-ethernet = "{ipaddr}/{cidr} 󰈀";
          format-disconnected = "Disconnected 󱛅";
          tooltip-format = "{ifname} via {gwaddr} 󰛳";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };
        "sway/workspaces" = {
          disable-scroll = true;
        };
      }
    ];
    style = let
      theme = import ../themes/current-theme.nix;
    in /*css*/ ''
      * {
        border: none;
        border-radius: 0;
        font-family: RobotoMono Nerd Font;
        font-size: 14px;
        font-weight: 500;
      }
      
      window#waybar {
        background-color: #${theme.background0};
        color: #${theme.foreground};
      }
      
      window#waybar.hidden {
        opacity: 0.2;
      }
      
      #workspaces button {
        padding: 0 5px;
        color: #${theme.foreground};
        border-radius: 5px;
      }
      
      #workspaces button.focused {
        background-color: #${theme.foreground};
        color: #${theme.background0};
      }
      
      #workspaces button.urgent {
        background-color: #${theme.regular1};
      }
      
      widget > * {
        margin-top: 6px;
        margin-bottom: 6px;
      }
      
      .modules-left > widget > * {
        margin-left: 12px;
        margin-right: 12px;
      }
      
      .modules-left > widget:first-child > * {
        margin-left: 6px;
      }
      
      .modules-left > widget:last-child > * {
        margin-right: 18px;
      }
      
      .modules-right > widget > * {
        padding: 0 12px;
        margin-left: 0;
        margin-right: 0;
        color: #${theme.background0};
        background-color: #${theme.foreground};
      }
      
      .modules-right > widget:first-child > * {
        border-radius: 5px 0 0 5px;
      }
      
      .modules-right > widget:last-child > * {
        border-radius: 0 5px 5px 0;
        margin-right: 6px;
      }
      
      #mode {
        background: transparent;
        color: #${theme.bright1};
      }
      
      @keyframes blink {
        to {
          color: #${theme.foreground};
        }
      }
      
      #battery.critical:not(.charging) {
        animation-name: blink;
        animation-duration: 1s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      
      label:focus {
        background-color: #${theme.background0};
      }
      
      tooltip {
        border-radius: 5px;
        background: #${theme.background2};
      }
      
      tooltip label {
        color: #${theme.foreground};
      }
    '';
  };
}
