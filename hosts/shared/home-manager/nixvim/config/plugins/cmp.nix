{
  plugins.lspkind = {
    enable = true;
    cmp.enable = true;
  };

  plugins.luasnip.enable = true;
  plugins.cmp = {
    enable = true;
    autoEnableSources = true;
    settings.sources = [
      {name = "nvim_lsp";}
      {name = "codeium";}
      {name = "luasnip";}
      {name = "path";}
      {name = "buffer";}
      {name = "rg";}
    ];


    settings.mapping = {
      __raw = ''
        cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        })
      '';
    };

    #settings.mapping = {
    #  "<C-b>" = "cmp.mapping.scroll_docs(-4)";
    #  "<C-f>" = "cmp.mapping.scroll_docs(4)";
    #  "<C-Space>" = ''
    #    cmp.mapping(function(fallback)
    #      local luasnip = require("luasnip")
    #      if cmp.visible() then
    #        cmp.select_next_item()
    #      elseif luasnip.locally_jumpable(1) then
    #        luasnip.jump(1)
    #      else
    #        fallback()
    #      end
    #    end, { "i", "s" })
    #  '';
    #  "<S-Tab>" = ''
    #    cmp.mapping(function(fallback)
    #    local luasnip = require("luasnip")
    #      if cmp.visible() then
    #        cmp.select_prev_item()
    #      elseif luasnip.locally_jumpable(-1) then
    #        luasnip.jump(-1)
    #      else
    #        fallback()
    #      end
    #    end, { "i", "s" })
    #  '';
    #  "<CR>" = ''
    #    cmp.mapping({
    #      i = function(fallback)
    #       local luasnip = require("luasnip")
    #       if cmp.visible() and cmp.get_active_entry() then
    #          if luasnip.expandable() then
    #              luasnip.expand()
    #          else
    #            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
    #          end
    #       else
    #         fallback()
    #       end
    #      end,
    #      s = cmp.mapping.confirm({ select = true }),
    #      c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
    #    })'';
    #};
  };

  plugins.cmp-cmdline.enable = true;
  plugins.cmp.cmdline = {
    "/" = {
      mapping = {
        __raw = "cmp.mapping.preset.cmdline()";
      };
      sources = [
        {
          name = "buffer";
        }
      ];
    };
    ":" = {
      mapping = {
        __raw = "cmp.mapping.preset.cmdline()";
      };
      sources = [
        {
          name = "path";
        }
        {
          name = "cmdline";
          option = {
            ignore_cmds = [
              "Man"
              "!"
            ];
          };
        }
      ];
    };
  };
}
