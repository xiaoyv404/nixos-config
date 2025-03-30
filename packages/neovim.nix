{
  inputs,
  outputs,
  system,
  ...
}:
let
  nixvimWithModule = inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
    extraSpecialArgs = {
      inherit outputs;
      inherit (inputs) nvix;
      inputs = inputs // {
        buffer-manager = inputs.nvix.inputs.buffer-manager;
      };
    };
    module = {
      imports = [
        inputs.nvix.nvixModules.utils
        inputs.nvix.nvixModules.general
        inputs.nvix.nvixModules.buffer
        inputs.nvix.nvixModules.explorer
        inputs.nvix.nvixModules.telescope
        inputs.nvix.nvixModules.aesthetics
        inputs.nvix.nvixModules.git
        inputs.nvix.nvixModules.lsp
        inputs.nvix.nvixModules.cmp
        inputs.nvix.nvixModules.lualine
        inputs.nvix.nvixModules.treesitter
        inputs.nvix.nvixModules.auto-session

        outputs.modules.neovim.customization
        outputs.modules.neovim.colorschemes
        outputs.modules.neovim.snacks
        outputs.modules.neovim.lang
        outputs.modules.neovim.toggleterm
        outputs.modules.neovim.hop
      ];
    };
  };
in
nixvimWithModule.overrideAttrs (
  _finalAttrs: _prevAttrs: {
    pname = "neovim";
  }
)
