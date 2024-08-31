{ config, pkgs, ... }:

{
  imports = [
    ./starship.nix
  ];

  home.packages = with pkgs; [
    eza fd ripgrep bat skim
  ];

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
}
