{
  inputs,
  outputs,
  pkgs,
  ...
}: rec {
  neovim = pkgs.callPackage ./neovim.nix {inherit inputs outputs;};
  neovimPlugins = pkgs.callPackage ./neovimPlugins {};
}
