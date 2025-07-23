{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    outputs.modules.nixos.hosts.home
    outputs.modules.nixos.users.xiaoyv

    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {
        inherit inputs outputs;
      };
      home-manager.users.xiaoyv = import ./home.nix;
    }
  ];

  environment.systemPackages = with pkgs; [
    nix-output-monitor
    nh
    nixfmt-rfc-style
  ];
  system.stateVersion = "25.11";
}
