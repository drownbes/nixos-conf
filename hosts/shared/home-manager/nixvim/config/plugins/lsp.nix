{
  plugins.lsp = {
    enable = true;
    servers = {
      nil_ls.enable = true;
      html.enable = true;
      cssls.enable = true;
    };

    keymaps.lspBuf = {
      gd = "definition";
      gD = "declaration";
      gi = "implementation";
      gr = "references";
      "<space>ca" = "code_action";
    };
  };

  plugins.rustaceanvim.enable = true;
  plugins.codeium-nvim.enable = true;

  plugins.lspsaga = {
    enable = true;
  };
}
