{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
  home.packages = [
    pkgs.ueberzugpp
  ];
}
