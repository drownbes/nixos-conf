{pkgs,...}:{
  environment.systemPackages = with pkgs; [
    vscode
    unstable.code-cursor
    unstable.obsidian
    zoom-us
  ];
}
