# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}: {
  imports = [
    outputs.modules.nixos.hosts.home
    outputs.modules.nixos.users.xiaoyv
    outputs.modules.programs.icalingua-plus-plus

    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.home-manager
    {
      # home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = {
        inherit inputs outputs;
      };
      home-manager.users.xiaoyv = import ./home.nix;
    }
    inputs.vscode-server.nixosModules.default
    ({
      config,
      pkgs,
      ...
    }: {
      services.vscode-server.enable = true;
    })
  ];

  networking = {
    hostName = "nixos-vm"; # Define your hostname.
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    proxy.default = "http://192.168.1.2:7890";
  };

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  services.pipewire = {
    enable = false;
    pulse.enable = true;
  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  environment.systemPackages = with pkgs; [
    element-desktop
    yubikey-personalization
    inputs.alejandra.defaultPackage.x86_64-linux
  ];

  programs.icalingua-plus-plus = {
    enable = true;
  };

  system.stateVersion = "25.05"; # Did you read the comment?
}
