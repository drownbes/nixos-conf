{ programs.nixvim = {
  opts = {
    # Editor settings
    termguicolors = true;
    number = true;
    showmatch = true;
    ignorecase = true;
    smartcase = true;
    hlsearch = true;
    incsearch = true;
    inccommand = "nosplit";
    signcolumn = "yes";

    # Autoread
    autoread = true;

    # Tabs and spaces
    expandtab = true;
    softtabstop = 2;
    shiftwidth = 2;
    tabstop = 2;

    # Messages
    shortmess = "atI";

    # Modelines
    modeline = true;

    # Indentation
    autoindent = true;
    smartindent = true;
    cindent = true;
    # Filetype indent (not directly supported in options, but can be set with extraConfig)

    # Command line completions
    wildmenu = true;
    wildmode = ["list:longest" "full"];

    # Undo settings
    undofile = true;
    undolevels = 3000;
    undoreload = 10000;
    updatecount = 100;
    history = 2000;

    backup = true;
    backupdir = "$HOME/.config/nvim/backup//";
    swapfile = false;
    hidden = true;
    lazyredraw = false;
  };
  globals = {
    nowrapscan = true;
    mapleader = "\\";
  };
  extraConfigLua = ''
    local prefix = vim.fn.stdpath("config") .. "/nvim"
    vim.opt.undodir = prefix .. "/undo/"
    vim.opt.backupdir = prefix .. "/backup/"
    vim.opt.directory = prefix .. "/swap/"
  '';
};}
