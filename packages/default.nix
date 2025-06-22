{
  inputs,
  outputs,
  pkgs,
  ...
}: rec {
  neovim = pkgs.callPackage ./neovim.nix {inherit inputs outputs;};
  neovimPlugins = pkgs.callPackage ./neovimPlugins {};
  icalingua-plus-plus = pkgs.callPackage ./icalingua-plus-plus {};
}
