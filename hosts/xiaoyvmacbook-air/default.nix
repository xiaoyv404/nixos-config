{
  config,
  lib,
  outputs,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    {
      # home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {
        inherit inputs outputs;
      };
      home-manager.users.xiaoyv = import ./home.nix;
    }
  ];
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
  ];
  system.stateVersion = 6;
  nix = {
    settings = {
      substituters = [
        "https://mirrors.ustc.edu.cn/nix-channels/store"
        # "https://mirror.sjtu.edu.cn/nix-channels/store"
      ];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      nix-path = lib.mkForce "nixpkgs=/etc/nix/inputs/nixpkgs";
    };
    optimise.automatic = true;
    gc = {
      automatic = true;

      options = "--delete-older-than 14d";
    };
    registry.nixpkgs.flake = inputs.nixpkgs;
    channel.enable = false;
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    nixVersions.latest
    just
    nix-output-monitor
    nh
    nixfmt-rfc-style
    alacritty
  ];

}
