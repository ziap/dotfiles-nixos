{ config, pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = {
      ignore-empty-password = true;
      
      color = "282828cd";
      indicator-radius = 80;
      indicator-thickness = 25;
      
      key-hl-color = "b8bb26";
      bs-hl-color = "fb4934";
      
      separator-color = "282828cd";
      
      line-color = "282828";
      
      inside-color = "282828";
      inside-clear-color = "fabd2f";
      inside-ver-color = "83a598";
      inside-wrong-color = "fb4934";
      
      ring-color = "98971a";
      ring-ver-color = "458588";
      ring-clear-color = "b57614";
      ring-wrong-color = "cc241d";

      text-color = "282828";
      text-clear-color = "282828";
      text-caps-lock-color = "282828";
      text-ver-color = "282828";
      text-wrong-color = "282828";
    };
  };
}
