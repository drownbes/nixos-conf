{pkgs,...}:{
  environment.systemPackages = with pkgs; [
    wget
    clipboard-jh
    xclip

    p7zip
    rar
    zip
  ];
}
