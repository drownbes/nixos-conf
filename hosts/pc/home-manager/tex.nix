{pkgs, ...}: {
  programs.texlive = {
    enable = true;
    extraPackages = tpkgs: { inherit (tpkgs) scheme-full; };
  };
  home.packages = [
    pkgs.texstudio
  ];

}
