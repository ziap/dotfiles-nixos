{ config, pkgs, ... }:

let
  username = "zap";
in {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [ "networkmanager" "wheel" "video" "libvirtd" ];
    packages = with pkgs; [];
  };

  # Enable flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    git zip unzip wget file
    man-pages man-pages-posix
    wineWowPackages.stable
  ];

  # Auto login
  services.greetd = let 
    tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
    session = "${pkgs.sway}/bin/sway";
  in {
    enable = true;
    settings = {
      initial_session = {
        command = session;
        user = username;
      };
      default_session = {
        command = ''
          ${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --time
            --remember --remember-user-session -cmd ${session}
        '';
        user = "greeter";
      };
    };
  };

  # Enable sway and required programs
  services.gnome.gnome-keyring.enable = true;
  programs.light.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = [];
  };

  services.flatpak.enable = true;
  documentation.dev.enable = true;

  # Enable Pipewire (multimedia codecs)
  # <https://nixos.wiki/wiki/PipeWire>
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable XDG Desktop integration for Sway
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  # Virtualization
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = [ pkgs.virtiofsd ];
    };
    spiceUSBRedirection.enable = true;
  };
}
