{ config, pkgs, ... }:

{
  # Configures GUI-based desktop apps
  imports = [
    ./firefox.nix
    ./mimeapps.nix
    ./zathura.nix
    ./imv.nix
  ];

  # GNOME related configurations
  dconf = {
    enable = true;

    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };

    iconTheme = {
      name = "ePapirus";
      package = pkgs.epapirus-icon-theme;
    };
  };
}
