{ config, pkgs, ... }:

{
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

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}

