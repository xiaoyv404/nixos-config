{ pkgs, ... }:
{
  wezrs = pkgs.callPackage ./wezrs.nix { inherit (pkgs.fishPlugins) buildFishPlugin; };
}
