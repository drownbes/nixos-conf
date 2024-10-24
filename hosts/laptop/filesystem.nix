{inputs, ...}: {
  imports = [
    inputs.hardware.nixosModules.common-pc-ssd
  ];
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0ec6fa9e-b9a0-4dbd-a162-6163c3a4ab3d";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E436-7E56";
    fsType = "vfat";
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/f2776121-f7cb-46d8-996c-0c61043f1cc6";}
  ];
}
