{
  programs.nixvim = {
    globals = {
      mapleader = "\\";
    };
    extraConfigLua = ''

      vim.cmd("nore ; :")
      vim.cmd("tnoremap <Esc> <C-\\><C-n>")
    '';
  };
}
