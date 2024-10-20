{pkgs, ...}: {
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    package = pkgs.unstable.ollama;
  };

  services.open-webui = {
    enable = true;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      WEBUI_AUTH = "False";
    };
  };
}
