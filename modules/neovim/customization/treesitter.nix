{ lib, pkgs, ... }:
{
  plugins.treesitter = {
    grammarPackages = lib.mkForce [ ];
    gccPackage = pkgs.stdenv.cc;
    nodejsPackage = pkgs.nodejs;

    settings = {
      auto_install = true;
      highlight.enable = true;
      incremental_selection.enable = true;
      indent.enable = true;
    };
  };
}
