{
  inputs,
  outputs,
  pkgs,
  ...
}: rec {
  fishPlugins = pkgs.callPackage ./fishPlugins {};
  trzsz-go = pkgs.callPackage ./trzsz-go.nix {};
}
