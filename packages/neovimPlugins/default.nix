{ pkgs, ... }:
let
  callVimPlugins =
    pack: args: pkgs.callPackage pack ({ inherit (pkgs.vimUtils) buildVimPlugin; } // args);
in
{
  auto-indent = callVimPlugins ./auto-indent.nix { };
}
