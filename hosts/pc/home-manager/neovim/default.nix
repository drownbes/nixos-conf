{
  lib,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraLuaConfig = lib.fileContents ./init.lua;
    package = pkgs.unstable.neovim-unwrapped;
  };
}
