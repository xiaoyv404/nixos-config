{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nixvim.nixosModules.nixvim];

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
    };
    defaultEditor = true;
    extraPlugins = [pkgs.vimPlugins.gruvbox];
    colorscheme = "gruvbox";
  };
}
