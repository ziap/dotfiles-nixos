{
  description = "Home Manager configuration of zap";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    # Set home manager as the default package so that we can `nix run .`
    defaultPackage = home-manager.defaultPackage;

    # Home manager configuration modules
    homeConfigurations."zap" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
    };
  };
}
