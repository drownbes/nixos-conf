{...}: {
  #TODO: install extensions
  programs.librewolf = {
    enable = true;
    settings = {
      "media.ffmpeg.vaapi.enabled" = true;
    };
  };
}
