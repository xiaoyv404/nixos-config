{
  lib,
  inputs,
  outputs,
  pkgs,
  ...
}:
let
  self-defined = pkgs.callPackage ../../../packages {
    inherit inputs outputs;
  };
in
{
  filetype.extension = {
    "mdx" = "markdown.mdx";
  };

  plugins = {
    ts-autotag.enable = true;
    ts-comments.enable = true;

    lsp.servers = {
      ts_ls.enable = true;
      tailwindcss.enable = true;
      jsonls.enable = true;
      html.enable = true;
      eslint.enable = true;
      cssls.enable = true;
      astro.enable = true;
      mdx_analyzer = {
        enable = true;
        filetypes = [ "markdown.mdx" ];
        package = self-defined.mdx-language-server;
        cmd = [
          "mdx-language-server"
          "--stdio"
        ];
      };
    };

    otter.enable = lib.mkForce false;
  };
}
