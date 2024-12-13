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

## Installation

Clone the repository

```bash
git clone https://github.com/ziap/dotfiles-nixos dotfiles
cd dotfiles
```

Change the username home directory in `home.nix` and `user.nix`

```nix
# home.nix
{
  home = let 
    username = "<your username>";
  in {
    username = username;
    homeDirectory = "/home/${username}";
    # ...
  };
}

# user.nix
let
  username = "<your username>";
in {
  # ...
}
```

Include `user.nix` in your `configuration.nix`

```nix
# Configuration.nix
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./user.nix
  ];

  # ...
}
```

Install and activate home-manager

```bash
nix run . -- switch --flake .
```

# License

This project is licensed under the [GPL-3.0 license](LICENSE).
