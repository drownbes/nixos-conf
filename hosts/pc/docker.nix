{...}: {
  virtualisation.docker = {
    enable = true;
  };
  hardware.nvidia-container-toolkit.enable = false;
}
