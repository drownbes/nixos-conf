{
  pkgs,
  ...
}: {
  imports = [
  ];
  services.xserver.videoDrivers = ["nvidia"];
  # beta driver buildable with xan kernel
  # nvidia setting require patch that is in unstable right now
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement = {
      enable = true;
    };
    open = false;
    nvidiaSettings = true;
    forceFullCompositionPipeline = true;
  };

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.systemPackages = with pkgs; [
    vulkan-loader
    vulkan-validation-layers
    vulkan-tools
  ];

  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.nvidia-vaapi-driver
      pkgs.vaapiVdpau
      pkgs.libvdpau-va-gl
    ];
  };
}
