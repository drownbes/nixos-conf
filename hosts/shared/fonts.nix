{pkgs, ...}: {
  fonts.packages = with pkgs; [
    nerdfonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    fira-code-nerdfont
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    hack-font
    unifont
    font-awesome
    jetbrains-mono
  ];
}
