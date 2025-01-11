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

      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
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
      name = "ePapirus-Dark";
      package = pkgs.epapirus-icon-theme;
    };
  };
}
