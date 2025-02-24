{
  plugins.lspkind = {
    enable = true;
    cmp.enable = true;
  };

  plugins.luasnip.enable = true;

  plugins.cmp-ai = {
    enable = true;

    settings.__raw = ''
      {
          max_lines = 100,
          provider = 'Ollama',
          provider_options = {
            model = 'qwen2.5-coder:7b-base-q8_0',
            prompt = function(lines_before, lines_after)
            -- You may include filetype and/or other project-wise context in this string as well.
            -- Consult model documentation in case there are special tokens for this.
              return "<|fim_prefix|>" .. lines_before .. "<|fim_suffix|>" .. lines_after .. "<|fim_middle|>"
            end,
          },
          notify = true,
          notify_callback = function(msg)
            vim.notify(msg)
          end,
          run_on_every_keystroke = false,
        }
    '';
  };

  #plugins.copilot-cmp.enable = true;
  #plugins.copilot-lua = {
  #  enable = true;
  #  suggestion.enabled = false;
  #  panel.enabled = false;
  #};

  plugins = {
    cmp-nvim-lsp.enable = true;
    cmp-path.enable = true;
    cmp-buffer.enable = true;
    cmp-rg.enable = true;
  };

  plugins.cmp = {
    enable = true;
    autoEnableSources = false;
    settings.sources = [
      {name = "nvim_lsp";}
      #{name = "codeium";}
      #{name = "copilot";}
      #{name = "cmp_ai";}
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
