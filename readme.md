<div align="center">

# Zap's NixOS dotfiles

My custom environment ported to NixOS and managed with home-manager

</div>

## Informations

- OS: [NixOS](https://nixos.org/)
- WM: [Niri](https://github.com/YaLTeR/niri/)
- Shell: [Fish](https://fishshell.com/) with [Starship prompt](//starship.rs/)
- Editor: [Neovim](https://neovim.io/)
- Terminal: [Kitty](https://sw.kovidgoyal.net/kitty/)
- Browser: [Firefox](https://www.mozilla.org/en-US/firefox/)
- Launcher: [Rofi](https://github.com/davatorium/rofi), [wayland fork](https://github.com/lbonn/rofi)
- Bar: [Waybar](https://github.com/Alexays/Waybar)
- Colorscheme: [Gruvbox](https://github.com/morhetz/gruvbox)

## Screenshots

TBA

## Installation

Clone the repository

```bash
git clone https://github.com/ziap/dotfiles-nixos dotfiles
cd dotfiles
```

Change the username and home directory in `home.nix` and `user.nix`

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
# configuration.nix
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
sudo nixos rebuild switch
nix run . -- switch --flake .
```

# License

This project is licensed under the [GPL-3.0 license](LICENSE).
