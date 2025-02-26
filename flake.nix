{
  description = "Home Manager configuration of zap";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: let
    forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    # Set home manager as the default package so that we can `nix run .`
    packages = forAllSystems (system: {
      default = home-manager.packages.${system}.default;
    });

    # Home manager configuration modules
    homeConfigurations."zap" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
    };
  };
}
