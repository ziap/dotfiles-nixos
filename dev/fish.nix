{ config, pkgs, ... }:

{
  imports = [
    ./starship.nix
  ];

  home.packages = with pkgs; [
    eza fd ripgrep bat skim
  ];

  programs.fish = {
    enable = true;

    functions = {
      mkcd = ''
        mkdir $argv
        cd $argv
      '';
    };

    shellAliases = {
      cat = "bat";
      ls = "eza --git --icons";
      ll = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      cdtemp = "cd (mktemp -d)";
    };

    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting

      function fish_hybrid_key_bindings
        # Emacs binding in insert mode
        fish_default_key_bindings -M insert
        fish_vi_key_bindings --no-erase
      end
      
      set -g fish_key_bindings fish_hybrid_key_bindings
      bind -M insert -k nul accept-autosuggestion
      
      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_replace underscore
      set fish_cursor_external line
      set fish_cursor_visual block
    '';
  }; 
}
