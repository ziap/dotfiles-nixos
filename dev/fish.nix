{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    functions = {
      mkcd = ''
        mkdir $argv
        cd $argv
      '';

      forward-or-edit = ''
        if commandline -P
          commandline -f forward-char
        else
          edit_command_buffer
        end
      '';
    };

    shellAliases = import ./shell-aliases.nix "fish" // {
      cdtemp = "cd (mktemp -d)";
    };

    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting

      set -g fish_key_bindings fish_vi_key_bindings
      bind -M insert -k nul accept-autosuggestion
      bind -M insert \cP up-or-search
      bind -M insert \cN down-or-search
      bind -M insert \cF forward-or-edit
      bind -M insert \cB backward-char

      set fish_cursor_default block
      set fish_cursor_insert line
      set fish_cursor_replace_one underscore
      set fish_cursor_replace underscore
      set fish_cursor_external line
      set fish_cursor_visual block
    '';
  }; 
}
