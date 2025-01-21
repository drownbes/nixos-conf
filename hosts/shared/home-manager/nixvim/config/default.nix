{
  imports = [
    ./options.nix
    ./performance.nix
    ./keymaps.nix
    ./plugins
  ];

  programs.nixvim.colorschemes.onedark.enable = true;
  programs.nixvim.plugins.web-devicons.enable = true;
}
