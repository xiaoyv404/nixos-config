{ lib, ... }:
{
  plugins.cmp.settings.mapping = lib.mkForce {
    __raw = ''
      cmp.mapping.preset.insert({
        ["<c-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<c-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

        ["<C-l>"] = cmp.mapping(function(fallback)
          local luasnip = require("luasnip")
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          elseif luasnip.jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-h>"] = cmp.mapping(function(fallback)
          local luasnip = require("luasnip")
          if luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ---@diagnostic disable-next-line
        ["<c-space>"] = cmp.mapping(function()
          local ok,_ = pcall(require, "copilot")
          if ok then
            vim.g.copilot_no_tab_map = true
            vim.g.copilot_assume_mapped = true
            vim.g.copilot_tab_fallback = ""

            local suggestion = require("copilot.suggestion")
            if suggestion.is_visible() then
              suggestion.accept()
            else
              cmp.mapping.complete()
            end
          end
        end,{ "i", "s" }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
          if cmp.visible() then
            local entry = cmp.get_selected_entry()
            if not entry then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            end
            cmp.confirm()
          else
            fallback()
          end
        end, {"i","s","c",}),
      })
    '';
  };
  # Reference: https://github.com/hrsh7th/nvim-cmp/wiki/Example-mappings#intellij-like-mapping
}
