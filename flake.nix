{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
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

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "git+https://mirrors.ustc.edu.cn/homebrew-core.git";
      flake = false;
    };
    homebrew-cask = {
      url = "git+https://mirrors.ustc.edu.cn/homebrew-cask.git";
      flake = false;
    };
    claude-code.url = "github:sadjow/claude-code-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nix-darwin,
      nix-homebrew,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      forAllSystems = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
    in
    {
      overlays = import ./overlays { inherit inputs outputs; };
      modules = import ./modules;
      legacyPackages = forAllSystems (
        system:
        import ./packages {
          inherit inputs outputs;
          pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
          };
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
        mba-utm = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/mba-utm
          ];
        };
      };
      darwinConfigurations = {
        xiaoyvmacbook-air = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            (
              { config, ... }:
              {
                nixpkgs.config.allowUnfree = true;
              }
            )
            ./hosts/xiaoyvmacbook-air
          ];
        };
        xiaoyvmac-mini = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./hosts/xiaoyvmac-mini
          ];
        };
      };
    };
}
