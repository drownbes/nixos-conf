{lib, ...}: let 
  recMerge = mlist: lib.lists.foldl lib.attrsets.recursiveUpdate {} mlist;
in {
  programs.nixvim = recMerge [
    (import ./yanky.nix)
    (import ./toggleterm.nix)
    (import ./lualine.nix)
    (import ./telescope.nix)
    (import ./treesitter.nix)
    (import ./gitsigns.nix)
    (import ./trouble.nix)
    (import ./neo-tree.nix)
    (import ./cmp.nix)
    (import ./lsp.nix)
    (import ./nix-develop.nix)
  ];
}
