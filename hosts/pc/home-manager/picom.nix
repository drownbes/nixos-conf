{pkgs, ...}: {
  services.picom = {
    package = pkgs.unstable.picom;
    enable = true;
    vSync = true;
    backend = "egl";
    fade = true;
    extraArgs = ["--no-use-damage"];
  };
}
