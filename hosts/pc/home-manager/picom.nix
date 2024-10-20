{...}: {
  services.picom = {
    enable = true;
    vSync = true;
    backend = "glx";
    fade = true;
  };
}
