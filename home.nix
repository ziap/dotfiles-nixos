{ config, pkgs, ... }:

{
  home.username = "zap";
  home.homeDirectory = "/home/zap";

  home.stateVersion = "23.11"; # Please read the comment before changing.

  programs.git = {
    enable = true;

    userName = "Zap";
    userEmail = "67962871+ziap@users.noreply.github.com";

    delta = {
      enable = true;
      options = {
        line-numbers = true;
        syntax-theme = "gruvbox-dark";
        side-by-side = false;
        file-modified-label = "modified:";
      };
    };

    extraConfig = {
      merge.tool = "nvimdiff3";
    };
  };

  programs.foot = {
    enable = true;
    server.enable = true;
    settings = {
      main = {
        font = "FiraCode Nerd Font:pixelsize=18";
	font-italic = "VictorMono Nerd Font:style=SemiBold Italic:pixelsize=18";
        initial-window-size-chars = "80x32";
      };
      colors = {
        background = "282828";
        foreground = "EBDBB2";
        
        regular0 = "282828";
        regular1 = "CC241D";
        regular2 = "98971A";
        regular3 = "D79921";
        regular4 = "458588";
        regular5 = "B16286";
        regular6 = "689D6A";
        regular7 = "A89984";
        
        bright0 = "928374";
        bright1 = "FB4934";
        bright2 = "B8BB26";
        bright3 = "FABD2F";
        bright4 = "83A598";
        bright5 = "D3869B";
        bright6 = "8EC07C";
        bright7 = "EBDBB2";
      };
      cursor = {
        beam-thickness = 1;
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    completionInit = ''
      autoload -U compinit
      zstyle ':completion:*' menu select
      zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
      zmodload zsh/complist
      compinit
      _comp_options+=(globdots)	

      ## Vim binding in tab completion select menu
      bindkey -M menuselect 'h' vi-backward-char
      bindkey -M menuselect 'j' vi-down-line-or-history
      bindkey -M menuselect 'k' vi-up-line-or-history
      bindkey -M menuselect 'l' vi-forward-char
    '';
    autosuggestion = {
      enable = true;
      strategy = [ 
        "completion"
      ];
    };
    syntaxHighlighting.enable = true;

    initExtra = ''
      ## Activate vi mode.
      bindkey -v
      
      ## Remove mode switching delay.
      KEYTIMEOUT=5
      
      ## Change cursor shape for different vi modes.
      zle-keymap-select() {
        case $KEYMAP in
          vicmd) echo -ne '\e[1 q';;      # block
          viins|main) echo -ne '\e[5 q';; # beam
        esac
      }
      zle -N zle-keymap-select
      
      zle-line-init() {
        zle -K viins
        echo -ne '\e[5 q'
      }
      zle -N zle-line-init
      
      echo -ne '\e[5 q'
      preexec() { echo -ne '\e[5 q' }

      ## Emacs binding in insert mode
      bindkey -M main '^P' up-line-or-history
      bindkey -M main '^N' down-line-or-history
      bindkey -M main '^F' forward-char
      bindkey -M main '^B' backward-char

      ## Fuzzy finder utilities
      function frm { fd --type=file | sk -m --preview 'file {}' | xargs -d '\n' rm }
      function fcd { cd "$(fd --type=d | sk --preview 'eza {} --icons -la')" }
      function fgd { cd $(dirname $(fd -H -g \*.git ~/*/) | sk --preview 'eza {} --git-ignore --icons -T') }
      function fca { bat "$(fd --type=file | sk --preview='bat {} --theme=gruvbox-dark --color=always')" }
      function fxo { xdg-open "$(fd --type=file | sk --preview 'file {}')" }
      function frg { sk --ansi -ic "rg {} --color=always --line-number" }
    '';
    shellAliases = {
      ls = "eza --git --icons";
      cat = "bat --theme=gruvbox-dark";
    };
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };

  programs.starship = {
    enable = true;
    settings = {
      format = ''
[░▒▓](fg:purple)$username[](bg:cyan fg:purple)$directory[](fg:cyan bg:yellow)$git_branch$git_status[](fg:yellow bg:blue)$python$elixir$elm$golang$java$julia$nodejs$nim$rust[](fg:blue bg:bright-blue)$docker_context[](fg:bright-blue)
$character'';
      username = {
        show_always = true;
        style_user = "bg:purple";
        style_root = "bg:purple bold";
        format = "[ 󱄅 $user ]($style)";
      };
      directory = {
        style = "bg:cyan";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          Documents = "󰈙 ";
          Downloads = " ";
          Music = " ";
          Pictures = " ";
        };
      };
      git_branch = {
        symbol = "";
        style = "bg:yellow";
        format = "[[ $symbol $branch ](bg:yellow)]($style)";
      };
      git_status = {
        style = "bg:yellow";
        format = "[[($all_status$ahead_behind )](bg:yellow)]($style)";
      };
      docker_context = {
        symbol = "";
        style = "bg:bright-blue";
        format = "[[ $symbol $context ](bg:#06969A)]($style) $path";
      };
      python = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol ($version) (\\($virtualenv\\)) ](bg:blue)]($style)";
      };
      elixir = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol ($version) ](bg:blue)]($style)";
      };
      elm = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol ($version) ](bg:blue)]($style)";
      };
      golang = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol ($version) ](bg:blue)]($style)";
      };
      java = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol ($version) ](bg:blue)]($style)";
      };
      julia = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol ($version) ](bg:blue)]($style)";
      };
      nodejs = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol ($version) ](bg:blue)]($style)";
      };
      nim = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol ($version) ](bg:blue)]($style)";
      };
      rust = {
        symbol = "";
        style = "bg:blue";
        format = "[[ $symbol ($version) ](bg:blue)]($style)";
      };
    };
  };

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

  programs.imv = {
    enable = true;
    settings = {
      options.background = "282828";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = "org.pwmt.zathura.desktop";

    "image/jpeg" = "imv.desktop";
    "image/bmp" = "imv.desktop";
    "image/gif" = "imv.desktop";
    "image/jpg" = "imv.desktop";
    "image/png" = "imv.desktop";
    "image/tiff" = "imv.desktop";
    "image/x-bmp" = "imv.desktop";
    "image/x-portable-anymap" = "imv.desktop";
    "image/x-portable-bitmap" = "imv.desktop";
    "image/x-portable-graymap" = "imv.desktop";
    "image/x-tga" = "imv.desktop";
    "image/x-xpixmap" = "imv.desktop";
    "image/svg+xml" = "imv.desktop";

    "video/x-ogm+ogg" = "mpv.desktop";
    "video/mpeg" = "mpv.desktop";
    "video/x-mpeg2" = "mpv.desktop";
    "video/x-mpeg3" = "mpv.desktop";
    "video/mp4v-es" = "mpv.desktop";
    "video/x-m4v" = "mpv.desktop";
    "video/mp4" = "mpv.desktop";
    "video/divx" = "mpv.desktop";
    "video/vnd.divx" = "mpv.desktop";
    "video/msvideo" = "mpv.desktop";
    "video/x-msvideo" = "mpv.desktop";
    "video/ogg" = "mpv.desktop";
    "video/quicktime" = "mpv.desktop";
    "video/vnd.rn-realvideo" = "mpv.desktop";
    "video/x-ms-afs" = "mpv.desktop";
    "video/x-ms-asf" = "mpv.desktop";
    "video/x-ms-wmv" = "mpv.desktop";
    "video/x-ms-wmx" = "mpv.desktop";
    "video/x-ms-wvxvideo" = "mpv.desktop";
    "video/x-avi" = "mpv.desktop";
    "video/avi" = "mpv.desktop";
    "video/x-flic" = "mpv.desktop";
    "video/fli" = "mpv.desktop";
    "video/x-flc" = "mpv.desktop";
    "video/flv" = "mpv.desktop";
    "video/x-flv" = "mpv.desktop";
    "video/x-theora" = "mpv.desktop";
    "video/x-theora+ogg" = "mpv.desktop";
    "video/x-matroska" = "mpv.desktop";
    "video/mkv" = "mpv.desktop";
    "video/webm" = "mpv.desktop";
    "video/x-ogm" = "mpv.desktop";
    "video/mp2t" = "mpv.desktop";
    "video/vnd.mpegurl" = "mpv.desktop";
    "video/3gp" = "mpv.desktop";
    "video/3gpp" = "mpv.desktop";
    "video/3gpp2" = "mpv.desktop";
    "video/dv" = "mpv.desktop";

    "audio/x-vorbis+ogg" = "mpv.desktop";
    "audio/aac" = "mpv.desktop";
    "audio/x-aac" = "mpv.desktop";
    "audio/vnd.dolby.heaac.1" = "mpv.desktop";
    "audio/vnd.dolby.heaac.2" = "mpv.desktop";
    "audio/aiff" = "mpv.desktop";
    "audio/x-aiff" = "mpv.desktop";
    "audio/m4a" = "mpv.desktop";
    "audio/x-m4a" = "mpv.desktop";
    "audio/mp1" = "mpv.desktop";
    "audio/x-mp1" = "mpv.desktop";
    "audio/mp2" = "mpv.desktop";
    "audio/x-mp2" = "mpv.desktop";
    "audio/mp3" = "mpv.desktop";
    "audio/x-mp3" = "mpv.desktop";
    "audio/mpeg" = "mpv.desktop";
    "audio/mpeg2" = "mpv.desktop";
    "audio/mpeg3" = "mpv.desktop";
    "audio/mpegurl" = "mpv.desktop";
    "audio/x-mpegurl" = "mpv.desktop";
    "audio/mpg" = "mpv.desktop";
    "audio/x-mpg" = "mpv.desktop";
    "audio/rn-mpeg" = "mpv.desktop";
    "audio/musepack" = "mpv.desktop";
    "audio/x-musepack" = "mpv.desktop";
    "audio/ogg" = "mpv.desktop";
    "audio/scpls" = "mpv.desktop";
    "audio/x-scpls" = "mpv.desktop";
    "audio/vnd.rn-realaudio" = "mpv.desktop";
    "audio/wav" = "mpv.desktop";
    "audio/x-pn-wav" = "mpv.desktop";
    "audio/x-pn-windows-pcm" = "mpv.desktop";
    "audio/x-realaudio" = "mpv.desktop";
    "audio/x-pn-realaudio" = "mpv.desktop";
    "audio/x-ms-wma" = "mpv.desktop";
    "audio/x-pls" = "mpv.desktop";
    "audio/x-wav" = "mpv.desktop";
    "audio/x-ms-asf" = "mpv.desktop";
    "audio/x-matroska" = "mpv.desktop";
    "audio/webm" = "mpv.desktop";
    "audio/vorbis" = "mpv.desktop";
    "audio/x-vorbis" = "mpv.desktop";
    "audio/x-shorten" = "mpv.desktop";
    "audio/x-ape" = "mpv.desktop";
    "audio/x-wavpack" = "mpv.desktop";
    "audio/x-tta" = "mpv.desktop";
    "audio/AMR" = "mpv.desktop";
    "audio/ac3" = "mpv.desktop";
    "audio/eac3" = "mpv.desktop";
    "audio/amr-wb" = "mpv.desktop";
    "audio/flac" = "mpv.desktop";
    "audio/mp4" = "mpv.desktop";
    "audio/x-pn-au" = "mpv.desktop";
    "audio/3gpp" = "mpv.desktop";
    "audio/3gpp2" = "mpv.desktop";
    "audio/dv" = "mpv.desktop";
    "audio/opus" = "mpv.desktop";
    "audio/vnd.dts" = "mpv.desktop";
    "audio/vnd.dts.hd" = "mpv.desktop";
    "audio/x-adpcm" = "mpv.desktop";
    "audio/m3u" = "mpv.desktop";
  };


  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "FiraCode" "VictorMono" ]; })
    eza fd ripgrep bat skim
    htop neofetch
  ];
  fonts.fontconfig.enable = true;

  home.file = {
  };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
