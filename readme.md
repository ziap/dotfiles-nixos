<div align="center">

# Zap's NixOS dotfiles

My custom environment ported to NixOS and managed with home-manager

</div>

## Informations

- OS: [NixOS](https://nixos.org/)
- WM: [sway](https://swaywm.org/)
- Shell: [fish](https://fishshell.com/)
- Editor: [neovim](https://neovim.io/)
- Terminal: [kitty](https://sw.kovidgoyal.net/kitty/)
- Browser: [firefox](https://www.mozilla.org/en-US/firefox/)
- Launcher: [rofi](https://github.com/davatorium/rofi), [wayland fork](https://github.com/lbonn/rofi)
- Bar: [waybar](https://github.com/Alexays/Waybar)
- Colorscheme: [gruvbox](https://github.com/morhetz/gruvbox)

## Screenshots

TBA

## Required settings in configuration.nix

```nix
{
    # Enable flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Enable sway
    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
        extraPackages = [];
    };

    # Enable light
    programs.light.enable = true;

    # Enable gnome keyring
    services.gnome.gnome-keyring.enable = true;

    # Enable flatpak
    services.flatpak.enable = true;

    # Developer manpages
    documentation.dev.enable = true;

    environment.systemPackages = with pkgs; [
        wget
        git
        vim # Fallback editor in case home-manager failed to bootstrap neovim
        home-manager
        man-pages
        man-pages-posix
    ];

    # Autologin
    services.greetd = let
        tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
        session = "${pkgs.sway}/bin/sway";
        username = "zap";
    in {
        enable = true;
        settings = {
            initial_session = {
                command = "${session}";
                user = "${username}";
            };
            default_session = {
                command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time -cmd ${session}";
                user = "greeter";
            };
        };
    };
}
```

## Installation

```bash
home-manager switch --flake github:ziap/dotfiles-nixos
```

It's astounding how much easier it is to set everything up compared to my Fedora setup.
