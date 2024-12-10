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
}
```

## Installation

```bash
home-manager switch --flake github:ziap/dotfiles-nixos
```

It's astounding how much easier it is to set everything up compared to my Fedora setup.
