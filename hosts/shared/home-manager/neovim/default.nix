{
  lib,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    extraLuaConfig = lib.fileContents ./init.lua;
    package = pkgs.unstable.neovim-unwrapped;
    extraPackages = with pkgs; [
      luajitPackages.jsregexp
      gcc
      gnumake
      unstable.nil
      unstable.helm-ls
      unstable.yaml-language-server
    ];
  };
}
