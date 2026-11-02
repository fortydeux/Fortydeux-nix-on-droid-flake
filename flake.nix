{
  description = "Nix-on-Droid configuration with a portable Home Manager profile.";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-26.05";
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid/master";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
    };
  };
  outputs = { self, nixpkgs, nixpkgs-stable, nix-on-droid, home-manager, nixvim, ... }: {
    nixOnDroidConfigurations.default = nix-on-droid.lib.nixOnDroidConfiguration {
      pkgs = import nixpkgs { system = "aarch64-linux"; };
      extraSpecialArgs = { inherit nixvim; pkgsStable = import nixpkgs-stable { system = "aarch64-linux"; }; };
      modules = [ ./nix-on-droid.nix ];
    };
  };
}
