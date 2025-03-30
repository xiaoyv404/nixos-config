{
  inputs,
  outputs,
  pkgs,
  ...
}:
rec {
  scws = pkgs.callPackage ./scws.nix { };
  zhparser =
    postgresql:
    pkgs.callPackage ./zhparser.nix {
      inherit scws postgresql;
    };
  fishPlugins = pkgs.callPackage ./fishPlugins { };
  trzsz-go = pkgs.callPackage ./trzsz-go.nix { };
  neovim = pkgs.callPackage ./neovim.nix { inherit inputs outputs; };
  neovimPlugins = pkgs.callPackage ./neovimPlugins { };
  mdx-language-server = pkgs.callPackage ./mdx-language-server { };
}
