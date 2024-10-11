{ config, pkgs, ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      format = ''
[░▒▓](fg:purple)$username[](bg:cyan fg:purple)$directory[](fg:cyan bg:yellow)$git_branch$git_status[](fg:yellow bg:blue)$python$elixir$elm$golang$java$julia$nodejs$nim$rust[](fg:blue bg:bright-blue)$docker_context[](fg:bright-blue)
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

}
