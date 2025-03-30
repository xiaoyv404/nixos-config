{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";

    alejandra = {
      url = "github:kamadorueda/alejandra/3.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";

    nvix = {
      url = "github:krishukr/nvix";
      inputs.nixvim.follows = "nixvim";
      inputs.flake-parts.follows = "nixvim/flake-parts";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    inherit (self) outputs;
    forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
  in {
    overlays = import ./overlays {inherit inputs outputs;};
    modules = import ./modules;
    legacyPackages = forAllSystems (
      system:
        import ./packages {
          inherit inputs outputs;
          pkgs = import nixpkgs {inherit system;};
        }
    );
    packages = forAllSystems (
      system: nixpkgs.lib.filterAttrs (_: v: nixpkgs.lib.isDerivation v) self.legacyPackages.${system}
    );

    nixosConfigurations = {
      nixos-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./hosts/nixos-vm
        ];
      };
      nixos-mini = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./hosts/nixos-mini
        ];
      };
    };
  };
}
