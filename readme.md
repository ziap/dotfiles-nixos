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

## Recommended settings in configuration.nix

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
  # NOTE: Add "video" to your users extraGroups
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
    vim
    home-manager
    man-pages
    man-pages-posix
  ];

  # Autologin <https://discourse.nixos.org/t/autologin-hyprland/38159/12>
  services.greetd = let 
    tuigreet = "${pkgs.greetd.tuigreet}/bin/tuigreet";
    session = "${pkgs.sway}/bin/sway";
  in {
    enable = true;
    settings = {
      initial_session = {
        command = session;
        user = "<your username>";
      };
      default_session = {
        command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time -cmd ${session}";
        user = "greeter";
      };
    };
  };

  # Pipewire <https://nixos.wiki/wiki/PipeWire>
  # rtkit is optional but recommended
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };
}
```

## Installation

Clone the repository

```bash
git clone https://github.com/ziap/dotfiles-nixos dotfiles
cd dotfiles
```

Change the username home directory in `home.nix` 

```nix
{
  home = let 
    username = "<your username>";
  in {
    username = username;
    homeDirectory = "/home/${username}";
    # ...
  };
}
```

Activate home-manager

```bash
home-manager switch --flake .
```
